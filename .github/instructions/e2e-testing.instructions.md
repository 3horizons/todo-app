---
applyTo: "e2e/**"
---

# E2E Testing Conventions (Playwright)

## Selector Priority

Use accessible selectors in this order of preference:
1. `getByRole('button', { name: /text/i })` — buttons, links, headings
2. `getByText(/text/i)` — visible text content
3. `getByPlaceholder(/text/i)` — input placeholders
4. `getByLabel(/text/i)` — form labels
5. `locator('[data-testid="name"]')` — only when no accessible alternative exists

Never use fragile selectors like CSS classes (`.bg-blue-500`) or DOM structure (`div > span:nth-child(2)`).

## API Mocking

All tests must mock API calls using `page.route()`. Tests must never depend on a running backend.

```typescript
// Mock in beforeEach for consistent baseline
test.beforeEach(async ({ page }) => {
  await page.route('**/api/todos*', (route) =>
    route.fulfill({ json: mockTodos })
  );
});

// Override in specific test for different state
test('shows empty state', async ({ page }) => {
  await page.route('**/api/todos*', (route) =>
    route.fulfill({ json: { todos: [] } })
  );
  await page.goto('/todos');
});
```

## Page Object Model

Every page must have a corresponding POM in `e2e/pages/`:

```typescript
import { Page, Locator } from '@playwright/test';

export class ExamplePage {
  readonly page: Page;
  readonly heading: Locator;

  constructor(page: Page) {
    this.page = page;
    this.heading = page.getByRole('heading', { name: /example/i });
  }

  async goto() {
    await this.page.goto('/example');
  }

  async doAction() {
    // User-facing action
  }
}
```

Rules:
- One class per page/component
- Locators as `readonly` properties defined in constructor
- Methods represent user actions, not implementation details
- `goto()` method navigates to the page

## Test Structure

```typescript
import { test, expect } from '@playwright/test';

test.describe('Page Name', () => {
  test.beforeEach(async ({ page }) => {
    // Setup mocks
    // Navigate to page
  });

  test('should [verb] [what]', async ({ page }) => {
    // Arrange (if additional setup needed)
    // Act
    // Assert
  });
});
```

Rules:
- Group with `test.describe` by page or feature
- Each test is independent — full setup in `beforeEach`
- Descriptive names: `should display stats when data loaded`
- Assert visible outcomes, not internal state

## Mock Data

Shared mock data lives in `e2e/fixtures/mock-data.ts`. Import and use across specs.

## Test Categories

Each spec should cover:
- **Rendering**: Page loads and displays expected content
- **Interaction**: Buttons, links, inputs work correctly
- **State changes**: Filters, search, toggles update the UI
- **CRUD operations**: Create/update via modals work with mocked API
- **Empty state**: UI handles no data gracefully
- **Error state**: UI handles API errors gracefully
- **Navigation**: Links route to correct pages
- **Mobile**: Responsive behavior (tested via mobile project in config)
