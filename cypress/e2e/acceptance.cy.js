describe('Acceptance Tests - Development Environment', () => {
  beforeEach(() => {
    // Ignore uncaught exceptions from application code
    cy.on('uncaught:exception', (err, runnable) => {
      // Returning false here prevents Cypress from failing the test
      console.log('Uncaught exception:', err.message);
      return false;
    });

    // Test against development environment
    cy.visit('https://d3bkw6ogs7ek14.cloudfront.net', {
      // Wait for page to fully load
      timeout: 30000
    });

    // Wait for page to be ready
    cy.get('body').should('be.visible');
    cy.wait(2000); // Additional wait for JavaScript to load
  })

  it('should load the development website', () => {
    cy.get('h1').should('contain', 'Static Website CI/CD Demo')
    cy.get('#env').should('contain', 'Development')
  })

  it('should have basic functionality', () => {
    // Quick acceptance test - just check if page loads and has basic elements
    cy.get('body').should('be.visible')
    cy.get('header').should('be.visible')
    cy.get('main').should('be.visible')
    cy.get('footer').should('be.visible')
  })

  it('should display environment badge', () => {
    cy.get('.environment-badge').should('contain', 'Development')
  })

  it('should have working links', () => {
    cy.get('.github-link').should('have.attr', 'href')
      .and('include', 'github.com')
  })

  it('should be responsive', () => {
    // Test mobile viewport
    cy.viewport('iphone-x')
    cy.get('h1').should('be.visible')
    cy.get('.feature-grid').should('be.visible')
  })

  it('should display all features', () => {
    cy.get('.feature-card').should('have.length', 4)
    cy.get('.feature-card').first().should('contain', 'Infrastructure as Code')
    cy.get('.feature-card').eq(1).should('contain', 'CI/CD Pipeline')
    cy.get('.feature-card').eq(2).should('contain', 'Cloud Storage')
    cy.get('.feature-card').eq(3).should('contain', 'Security')
  })

  it('should show tech stack', () => {
    cy.get('.tech-tag').should('contain', 'AWS S3')
    cy.get('.tech-tag').should('contain', 'Terraform')
    cy.get('.tech-tag').should('contain', 'GitHub Actions')
  })

  it('should display deployment info', () => {
    cy.get('#env-info').should('contain', 'Development')
    cy.get('#version').should('contain', '1.0.0')
  })

  it('should have working navigation', () => {
    cy.get('footer').should('be.visible')
    cy.get('.github-link').should('have.attr', 'href')
  })
}) 