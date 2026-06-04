async function berechne() {
    const zahl = document.getElementById('zahlInput').value;
    const ergebnisPara = document.getElementById('ergebnis');
    if (!zahl) {
        ergebnisPara.innerText = 'Bitte eine Zahl eingeben.';
        return;
    }
    try {
        const response = await fetch(`/api/quadrat?zahl=${zahl}`);
        const data = await response.json();
        if (data.quadrat !== undefined) {
            ergebnisPara.innerText = `Quadrat von ${data.eingabe} ist ${data.quadrat}.`;
        } else {
            ergebnisPara.innerText = `Fehler: ${data.fehler}`;
        }
    } catch (err) {
        ergebnisPara.innerText = 'Netzwerkfehler.';
    }
}
