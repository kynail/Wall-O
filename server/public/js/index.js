const childs = Array.from(document.getElementById("table-child").children);
console.log(childs);

childs.forEach(element => {
    element.onclick = function() {
        clickCell(element.id);
    }
});

function clickCell(fishName) {
    window.open("dashboard/fish?name=" + fishName, "_self");
}