describe('Acceptance Tests - Development Environment', () => {
  beforeEach(() => {
    // Test against development environment
    cy.visit('https://d3bkw6ogs7ek14.cloudfront.net')
  })

  it('should load the development website', () => {
    cy.get('h1').should('contain', 'Static Website CI/CD Demo')
    cy.get('#env').should('contain', 'Development')
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