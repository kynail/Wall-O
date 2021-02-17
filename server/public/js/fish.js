var logoBtn = document.getElementById("logo-button");
var removeFishBtn = document.getElementById("remove-fish");

logoBtn.onclick = function() {
    window.open("/dashboard", "_self");
}

removeFishBtn.onclick = function() {
    const fishName = removeFishBtn.getAttribute("name");

    if (confirm("Supprimer " + fishName + " ?") == true) {
        const response = fetch("http://localhost:8080/dashboard/fish", {
            method: "DELETE",
            headers: {
                'Content-Type': 'application/json',
                // "Content-Type": "application/x-www-form-urlencoded"
            },
            body: JSON.stringify({
                fishName: fishName
            })
        })
        window.open("/dashboard", "_self");
    }
}