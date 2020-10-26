function bloquearBoton(boton) {
    boton.classList.remove('learn-more');
    boton.classList.add('selected');
    boton.disabled = true;
    var imagen = boton.querySelectorAll("img")[0];
    imagen.src = "../resources/img/cancel.svg";
}
function activarBoton(boton, rutaImg) {
    boton.classList.remove('selected');
    boton.classList.add('learn-more');
    boton.disabled = false;
    var imagen = boton.querySelectorAll("img")[0];
    imagen.src = rutaImg;
}