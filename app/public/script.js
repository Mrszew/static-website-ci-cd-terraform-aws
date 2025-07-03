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

// Set deployment time
document.addEventListener('DOMContentLoaded', function() {
    const deployTime = new Date().toLocaleString();
    document.getElementById('deploy-time').textContent = deployTime;
    
    // Detect environment based on URL
    const currentUrl = window.location.href;
    if (currentUrl.includes('d3bkw6ogs7ek14.cloudfront.net')) {
        // Development environment
        document.getElementById('env').textContent = 'Development';
        document.getElementById('env-info').textContent = 'Development';
    } else {
        // Production environment
        document.getElementById('env').textContent = 'Production';
        document.getElementById('env-info').textContent = 'Production';
    }
    
    // Add some interactive features
    const featureCards = document.querySelectorAll('.feature-card');
    featureCards.forEach(card => {
        card.addEventListener('click', function() {
            this.style.transform = 'scale(1.05)';
            setTimeout(() => {
                this.style.transform = '';
            }, 200);
        });
    });
    
    // Add loading animation
    document.body.style.opacity = '0';
    setTimeout(() => {
        document.body.style.transition = 'opacity 0.5s ease';
        document.body.style.opacity = '1';
    }, 100);
});
