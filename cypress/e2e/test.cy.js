describe('Stopka', () => {
  it('powinna zawierać imię i nazwisko', () => {
    cy.readFile('app/public/index.html').should('include', 'Marcel Raszewski');
  });
});