describe('template spec', ()=>  {
    it('passes',()=>{
        cy.visit('../app/public/index.html') 
        cy.get('header').contains("Marcela Raszewskiego");
    })
})