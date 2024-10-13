// Skrypt do rozwijania sekcji "Dowiedz się więcej"
document.getElementById("learnMoreBtn").addEventListener("click", function() {
    var moreInfo = document.getElementById("moreInfo");
    if (moreInfo.style.display === "none") {
        moreInfo.style.display = "block";
        this.textContent = "Pokaż mniej";
    } else {
        moreInfo.style.display = "none";
        this.textContent = "Aby odtworzyć stronę rozwiń";
    }
});


document.getElementById("copyCodeBtn").addEventListener("click", function() {
    var code = document.getElementById("pythonCode").textContent;
    navigator.clipboard.writeText(code).then(function() {
        alert("Kod został skopiowany do schowka!");
    }).catch(function(error) {
        alert("Wystąpił błąd podczas kopiowania kodu: " + error);
    });
});
