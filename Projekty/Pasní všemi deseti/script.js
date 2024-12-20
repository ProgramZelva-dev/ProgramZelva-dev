const levels = [
    "Vanoce jsou cas rodinne pohody.",
    "Deti netrpelive cekaji na Jeziska.",
    "Vanoce jsou spojeny s tradicemi.",
    "Vanocni cukrovi voni po celem dome.",
    "Radost z darku pod stromkem je neopakovana.",
    "Vanocni trhy jsou plne svetylek a vune.",
    "Snih a vanocni stromek vytvari kouzelnou atmosferu.",
    "Stedrovecerni vecere je tradicne bohatou hostinou.",
    "Koledy zni z radia a vsichni si je pobrukuji.",
    "Deti s napetim oteviraji vanocni balicky.",
    "Vanocni stromecek je ozdoben svetly a koulemi.",
    "Vanoce jsou casem splnenych prani.",
    "Zima a vanocni prani jdou ruku v ruce.",
    "Vanocni pohledy a prani odesilame rodine a pratelum.",
    "Vanoce prinaseni radost a klid.",
    "Snih venku a teplo uvnitr je perfektni kombinace.",
    "Vanocni svicky dodavaji prijemnou atmosferu.",
    "Stastne a vesele Vanoce vsem!",
    "Vanocni koledy zni v kazdem domacnosti.",
    "Kouzelna atmosfera Vánoc je neopakovana."
];

let currentLevel = 0;
const textToType = document.getElementById('text-to-type');
const textInput = document.getElementById('text-input');
const startButton = document.getElementById('start-button');
const resultMessage = document.getElementById('result-message');
const levelDisplay = document.getElementById('level');
const themeToggle = document.getElementById('theme-toggle');

themeToggle.addEventListener('click', () => {
    document.body.classList.toggle('light-mode');
    themeToggle.textContent = document.body.classList.contains('light-mode') ? '☀️' : '🌙';
});

startButton.addEventListener('click', startLevel);

textInput.addEventListener('input', () => {
    const expectedText = levels[currentLevel - 1];
    if (textInput.value === expectedText) {
        resultMessage.innerText = 'Správně!';
        resultMessage.style.color = 'var(--success-color)';
        setTimeout(startLevel, 800); // Pauza mezi úrovněmi
    } else if (!expectedText.startsWith(textInput.value)) {
        resultMessage.innerText = 'Chyba, zkuste to znovu.';
        resultMessage.style.color = 'var(--error-color)';
    } else {
        resultMessage.innerText = '';
    }
});

function startLevel() {
    if (currentLevel < levels.length) {
        textInput.value = '';
        textToType.innerText = levels[currentLevel];
        textInput.focus();
        currentLevel++;
        levelDisplay.innerText = currentLevel;
        resultMessage.innerText = '';
    } else {
        textToType.innerText = '';
        resultMessage.innerText = 'Gratulujeme! Dokončili jste všechny úrovně.';
        startButton.disabled = true;
    }
}
