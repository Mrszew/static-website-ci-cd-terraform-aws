describe('Smoke Tests - Production Environment', () => {
  beforeEach(() => {
    // Test against production environment
    cy.visit('https://d3vddmdxeldp8p.cloudfront.net')
  })

  it('should load the production website', () => {
    cy.get('h1').should('contain', 'Static Website CI/CD Demo')
    cy.get('#env').should('contain', 'Production')
  })

  it('should have basic functionality', () => {
    // Quick smoke test - just check if page loads and has basic elements
    cy.get('body').should('be.visible')
    cy.get('header').should('be.visible')
    cy.get('main').should('be.visible')
    cy.get('footer').should('be.visible')
  })

  it('should display environment badge', () => {
    cy.get('.environment-badge').should('contain', 'Production')
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
}) 