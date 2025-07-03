// Skrypt do rozwijania sekcji "Dowiedz się więcej"
const learnMoreBtn = document.getElementById("learnMoreBtn");
if (learnMoreBtn) {
    learnMoreBtn.addEventListener("click", function() {
        var moreInfo = document.getElementById("moreInfo");
        if (moreInfo.style.display === "none") {
            moreInfo.style.display = "block";
            this.textContent = "Pokaż mniej";
        } else {
            moreInfo.style.display = "none";
            this.textContent = "Aby odtworzyć stronę rozwiń";
        }
    });
}

const copyCodeBtn = document.getElementById("copyCodeBtn");
if (copyCodeBtn) {
    copyCodeBtn.addEventListener("click", function() {
        var code = document.getElementById("pythonCode").textContent;
        navigator.clipboard.writeText(code).then(function() {
            alert("Kod został skopiowany do schowka!");
        }).catch(function(error) {
            alert("Wystąpił błąd podczas kopiowania kodu: " + error);
        });
    });
}

// Set deployment time
document.addEventListener('DOMContentLoaded', function() {
    const deployTime = new Date().toLocaleString();
    const deployTimeEl = document.getElementById('deploy-time');
    if (deployTimeEl) deployTimeEl.textContent = deployTime;

    // Detect environment based on URL
    const envEl = document.getElementById('env');
    const envInfoEl = document.getElementById('env-info');
    const currentUrl = window.location.href;
    if (envEl && envInfoEl) {
        if (currentUrl.includes('d3bkw6ogs7ek14.cloudfront.net')) {
            envEl.textContent = 'Development';
            envInfoEl.textContent = 'Development';
        } else {
            envEl.textContent = 'Production';
            envInfoEl.textContent = 'Production';
        }
    }

    // Add some interactive features
    const featureCards = document.querySelectorAll('.feature-card');
    if (featureCards && featureCards.length > 0) {
        featureCards.forEach(card => {
            if (card) {
                card.addEventListener('click', function() {
                    this.style.transform = 'scale(1.05)';
                    setTimeout(() => {
                        this.style.transform = '';
                    }, 200);
                });
            }
        });
    }

    // Add loading animation
    document.body.style.opacity = '0';
    setTimeout(() => {
        document.body.style.transition = 'opacity 0.5s ease';
        document.body.style.opacity = '1';
    }, 100);
});
