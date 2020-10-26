function verMensaje(src, mensaje, titulo) {
    document.getElementById("imagen").src = src;
    document.getElementById("articulo").textContent = mensaje;
    document.getElementById("tituloMensaje").textContent = titulo;
    $("#contenedorMensaje").fadeIn(1000);
}

function cerrandoFrame() {
    $("#contenedorMensaje").hide();
}