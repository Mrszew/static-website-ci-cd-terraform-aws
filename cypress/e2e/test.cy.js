describe('Plik index.html', () => {
  it('powinien zawierać słowo "Marcela Raszewskiego"', () => {
    cy.readFile('app/public/index.html').should('include', 'Marcela Raszewskiego');
  });
});