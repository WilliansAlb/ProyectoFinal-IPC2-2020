let opciones = ['GERENTES', 'CAJEROS', 'CLIENTES', 'TRANSACCIONES'];
let posiciones = 0;
let archivos = [];
let extensiones = [];
let posXml = 0;
let bases = [];
let fuentes = [];
window.onload = function () {
    $("#prueba1").bind("submit", function () {
        $.ajax({
            type: $(this).attr("method"),
            url: $(this).attr("action"),
            data: new FormData(this),
            processData: false,
            contentType: false,
            beforeSend: function () {
            },
            complete: function (data) {
            },
            success: function (data) {
                if (data.length > 0)
                {
                    cambiandoProgreso(6 / 6, "Completado");
                    cambiando(data, "resultadosArchivos", "Archivos");
                    $("#informar1").text("Puedes revisar con mayor detalle el estado de cada registro (ver los usuarios generados) o irte al inicio de sesión");
                    $("#botonesIngresado").fadeIn(1000);
                    document.getElementById("ingresarDatos").innerHTML = "VOLVER A INGRESAR DATOS<img src='../resources/img/add_database.svg' width='10%' style='display: inline-block;vertical-align: middle;'>";
                } else {
                    alert("error");
                }
            },
            error: function (data) {
                alert("Problemas al tratar de enviar el formulario");
            }
        });
        return false;
    });
};
function verificar() {
    const file1 = document.getElementById("archivo").files;
    for (let i = 0; i < file1.length; i++) {
        var actual = file1[i].webkitRelativePath;
        let pos = actual.indexOf('/');
        let pos2 = actual.indexOf('.');
        archivos.push(actual.substring(pos, actual.length));
        extensiones.push(actual.substring((pos2 + 1), actual.length));
        if (actual.substring((pos2 + 1), actual.length) === 'xml') {
            posXml = i;
        }
    }
    const file = document.getElementById("archivo").files[posXml];
    if (!file) {
        alert("NECESITAS SELECCIONAR UN ARCHIVO XML PRIMERO");
    } else {
        document.getElementById('ruta').innerText = ".." + archivos[posXml];
        document.getElementById("opciones").style.display = "";
    }
}
function cambiarArchivo(boton) {
    var div = boton.parentNode;
    div.style.display = "none";
    document.getElementById('ruta').innerText = "";
    document.getElementById('selectorArchivo').style.display = "";
    document.getElementById("visualizar").style.display = "none";
    $("#carga").css('margin-top', '10%');
    posiciones = 0;
    mostrarTabla(posiciones);
    $('#btn-con-iz').prop('disabled', true);
    bloquearBoton(document.getElementById("btn-con-iz"));
    $('#btn-con-de').prop('disabled', false);
    activarBoton(document.getElementById("btn-con-de"), "../resources/img/next.svg");
    document.getElementById('h-controlador').innerText = opciones[posiciones] + " A INGRESAR";
    var tablas = document.getElementById("tablas").querySelectorAll(".tablas");
    for (let i = 0; i < tablas.length; i++) {
        var tbodyActual = tablas[i].querySelector("tbody");
        tbodyActual.innerHTML = "";
    }
    $("#iniciarSesion").hide();
    $("#verificarDatos").show();
    $("#ingresarDatos").hide();
    $("#opciones").css("grid-template-columns","auto auto");
    document.getElementById("ingresarDatos").innerHTML = "INGRESAR DATOS<img src='../resources/img/add_database.svg' width='10%' style='display: inline-block;vertical-align: middle;'>";
}
function moverIzquierda() {
    if (posiciones === 1) {
        $('#btn-con-iz').prop('disabled', true);
        bloquearBoton(document.getElementById("btn-con-iz"));
    }
    posiciones -= 1;
    document.getElementById('h-controlador').innerText = opciones[posiciones] + " A INGRESAR";
    mostrarTabla(posiciones);
    $('#btn-con-de').prop('disabled', false);
    activarBoton(document.getElementById("btn-con-de"), "../resources/img/next.svg");
}

function moverDerecha() {
    if (posiciones === (opciones.length - 2)) {
        $('#btn-con-de').prop('disabled', true);
        bloquearBoton(document.getElementById("btn-con-de"));
    }
    posiciones += 1;
    document.getElementById('h-controlador').innerText = opciones[posiciones] + " A INGRESAR";
    mostrarTabla(posiciones);
    $('#btn-con-iz').prop('disabled', false);
    activarBoton(document.getElementById("btn-con-iz"), "../resources/img/previous.svg");
}

function mostrarTabla(posicion) {
    var divTablas = document.getElementById("tablas");
    var tablas = divTablas.querySelectorAll(".tablas");
    for (let i = 0; i < tablas.length; i++) {
        if (i === posicion) {
            tablas[i].style.display = "";
        } else {
            tablas[i].style.display = "none";
        }
    }
}

function loadDoc(botonClick) {
    $("#carga").css('margin-top', '0');
    $("#visualizar").show();
    $('#btn-con-iz').prop('disabled', true);
    botonClick.style.display = "none";
    document.getElementById("ingresarDatos").style.display = "";
    const file = document.getElementById("archivo").files[posXml];

    if (!file) {
        alert("NECESITAS SELECCIONAR UN ARCHIVO XML PRIMERO");
    } else {
        readDoc(file).then(parseDoc).then(showDocInTable).catch(onError)
    }
}

function readDoc(file) {
    const reader = new FileReader();

    return new Promise((ok) => {
        reader.readAsText(file);
        reader.onload = function () {
            ok(reader.result);
        };
    });
}

function parseDoc(rawXML) {
    const parser = new DOMParser();
    const xml = parser.parseFromString(rawXML, 'text/xml');
    return xml;
}

function verDPI(nombreArchivo, boton) {
    const file1 = document.getElementById("archivo").files;
    var posicion = -1;
    for (let i = 0; i < file1.length; i++) {
        var actual = file1[i].webkitRelativePath;
        if (actual.includes(nombreArchivo)) {
            posicion = i;
            break;
        }
    }
    if (posicion !== -1) {
        var reader = new FileReader();
        reader.readAsDataURL(file1[posicion]);
        reader.onload = function () {
            var texto = document.getElementById("tituloMensaje2").textContent + " " + boton;
            document.getElementById("tituloMensaje2").textContent = texto;
            $("#embeberDPI").attr('src', reader.result);
            $("#mostradorDPI").show();
            const base64String = reader.result
                    .replace('data:', '')
                    .replace(/^.+,/, '');

        };
        reader.onerror = function (error) {
            console.log('Error: ', error);
        };
    }
}

function showDocInTable(xml) {
    const table = document.querySelector('#gerentes > tbody');
    const table1 = document.querySelector('#cajeros > tbody');
    const table2 = document.querySelector('#clientes > tbody');
    const table3 = document.querySelector('#transacciones > tbody');

    const datasource = xml.querySelector('BANCO');

    const gerentes = datasource.querySelectorAll('GERENTE');
    const cajeros = datasource.querySelectorAll('CAJERO');
    const clientes = datasource.querySelectorAll('CLIENTE');
    const transacciones = datasource.querySelectorAll('TRANSACCION');

    Array.from(gerentes).map((gerente, i) => {
        const tr = document.createElement('tr');
        const CODIGO = tagToData(gerente.querySelector('CODIGO'));
        const TURNO = tagToData(gerente.querySelector('TURNO'));
        const NOMBRE = tagToData(gerente.querySelector('NOMBRE'));
        const DPI = tagToData(gerente.querySelector('DPI'));
        const DIRECCION = tagToData(gerente.querySelector('DIRECCION'));
        const SEXO = tagToData(gerente.querySelector('SEXO'));
        const PASSWORD = tagToData(gerente.querySelector('PASSWORD'));
        const ESTADO = document.createElement("td");
        ESTADO.textContent = "SIN INGRESAR";
        tr.append(CODIGO, NOMBRE, TURNO, DPI, DIRECCION, SEXO, PASSWORD, ESTADO);
        table.appendChild(tr);
    });
    console.log("gerentes---------------");
    Array.from(cajeros).map((cajero, i) => {
        console.log(i);
        const tr = document.createElement('tr');
        const CODIGO = tagToData(cajero.querySelector('CODIGO'));
        const TURNO = tagToData(cajero.querySelector('TURNO'));
        const NOMBRE = tagToData(cajero.querySelector('NOMBRE'));
        const DPI = tagToData(cajero.querySelector('DPI'));
        const DIRECCION = tagToData(cajero.querySelector('DIRECCION'));
        const SEXO = tagToData(cajero.querySelector('SEXO'));
        const PASSWORD = tagToData(cajero.querySelector('PASSWORD'));
        const ESTADO = document.createElement("td");
        ESTADO.textContent = "SIN INGRESAR";
        tr.append(CODIGO, NOMBRE, TURNO, DPI, DIRECCION, SEXO, PASSWORD, ESTADO);
        table1.appendChild(tr);
    });
    console.log("cajeros-------------------");
    Array.from(clientes).map((cliente, i) => {
        const tr = document.createElement('tr');
        const CODIGO = tagToData(cliente.querySelector('CODIGO'));
        const NOMBRE = tagToData(cliente.querySelector('NOMBRE'));
        const DPI = tagToData(cliente.querySelector('DPI'));
        const BIRTH = tagToData(cliente.querySelector('BIRTH'));
        const DIRECCION = tagToData(cliente.querySelector('DIRECCION'));
        const SEXO = tagToData(cliente.querySelector('SEXO'));
        const PASSWORD = tagToData(cliente.querySelector('PASSWORD'));
        const CUENTAS = cliente.querySelector("CUENTAS");
        var rutaPDF = cliente.querySelector("DPI-PDF").textContent;
        const PDF = document.createElement("td");
        PDF.innerHTML = "<center><button class='learn-more buttonEspecial' onclick='verDPI(\"" + rutaPDF + "\",\"" + cliente.querySelector('CODIGO').textContent + "\")'>VER DPI</button></center>";
        const CUENTASDATOS = document.createElement("td");
        const ESTADO = document.createElement("td");
        if (CUENTAS !== null) {
            const LISTADOC = CUENTAS.querySelectorAll("CUENTA");
            if (LISTADOC.length > 0) {
                CUENTASDATOS.innerHTML = '<center><button class="learn-more buttonEspecial" onclick="verCuentas(this)">CUENTAS<img src="../resources/img/expand.svg" width="15%" style="display: inline-block;vertical-align: middle;"></button></center>';
                CUENTASDATOS.innerHTML += '<table class="tablaDatos cuentas" style="display: none;"><thead><tr><th>Cuenta</th><th>Credito</th><th>Fecha creación</th></tr></thead><tbody>';
                CUENTASDATOS.innerHTML += '</tbody></table>';
                const tbody23 = CUENTASDATOS.querySelectorAll("table")[0];
                const tbody2 = tbody23.querySelectorAll("tbody")[0];
                for (let i = 0; i < LISTADOC.length; i++) {
                    const tr2 = document.createElement('tr');
                    tr2.className += "datosDeCuenta";
                    var cod = LISTADOC[i].querySelector("CODIGO").textContent;
                    var cre = LISTADOC[i].querySelector("CREDITO").textContent;
                    var fec = LISTADOC[i].querySelector("CREADA").textContent;
                    const td1 = document.createElement("td");
                    const td2 = document.createElement("td");
                    const td3 = document.createElement("td");
                    td1.id = CODIGO.textContent;
                    td1.textContent = cod;
                    td2.textContent = cre;
                    td3.textContent = fec;
                    tr2.append(td1, td2, td3);
                    tbody2.appendChild(tr2);
                }
                ESTADO.textContent = "SIN INGRESAR";
            }
        } else {
            CUENTASDATOS.style.backgroundColor = "red";
            ESTADO.textContent = "ERROR: cliente sin cuentas";
        }
        tr.className = "filaCliente";
        tr.append(CODIGO, NOMBRE, DPI, PDF, BIRTH, DIRECCION, SEXO, PASSWORD, CUENTASDATOS, ESTADO);
        table2.appendChild(tr);
    });
    Array.from(transacciones).map((transaccion, i) => {
        console.log(i);
        const tr = document.createElement('tr');
        const CODIGO = tagToData(transaccion.querySelector('CODIGO'));
        const CUENTA = tagToData(transaccion.querySelector('CUENTA-ID'));
        const FECHA = tagToData(transaccion.querySelector('FECHA'));
        const HORA = tagToData(transaccion.querySelector('HORA'));
        const TIPO = tagToData(transaccion.querySelector('TIPO'));
        const MONTO = tagToData(transaccion.querySelector('MONTO'));
        const CAJEROT = tagToData(transaccion.querySelector('CAJERO-ID'));
        const ESTADO = document.createElement("td");
        ESTADO.textContent = "SIN INGRESAR";
        tr.append(CODIGO, CUENTA, FECHA, HORA, TIPO, MONTO, CAJEROT, ESTADO);
        table3.appendChild(tr);
    });
}
function mostrar(boton) {
    $('#des').val(boton.value);

    var mensajew = $('#mensaje').width();
    var mensajeh = $('#mensaje').height();

    var height = $(window).height();
    var width = $(window).width();

    var posx = (width / 2) - (mensajew / 2);
    var posy = (height / 2) - (mensajeh / 2);

    if (posy > 0) {
        $('#mensaje').offset({top: 0});
    } else {
        $('#mensaje').offset({top: 0});
    }

    $('#descripcion').width(width);
    $('#descripcion').height(height);

    $('#descripcion').fadeIn(1000);
}
function ocultar(div) {
    $('#descripcion').fadeOut(500);
    //div.style.display = 'none';
}

function tagToData(tag) {
    const td = document.createElement('td');
    if (tag !== null) {
        td.textContent = tag.textContent;
        if (td.textContent === '') {
            td.style.backgroundColor = "red";
        }
    } else {
        td.textContent = '';
        td.style.backgroundColor = "red";
    }
    return td;
}

function onError(reason) {
    console.error(reason);
}

jQuery(function ($) {
    $('.progress').circleProgress();
    $('.progress').circleProgress({
        max: 100,
        value: 0,
        textFormat: 'percent'
    });
});

function verMensaje(titulo) {
    document.getElementById("tituloMensaje").textContent = titulo;
    $("#contenedorMensaje").fadeIn(1000);
    document.querySelector('#historial > tbody').innerHTML = "";
    document.querySelector('#resumen > tbody').innerHTML = "";

    var gerentes = [];
    var cajeros = [];
    var clientes = [];
    var cuentas = [];
    var transacciones = [];

    tablaGerentes = document.getElementById('gerentes');
    tbodyGerentes = tablaGerentes.getElementsByTagName("tbody")[0];
    filaGerentes = tbodyGerentes.getElementsByTagName("tr");

    tablaCajeros = document.getElementById('cajeros');
    tbodyCajeros = tablaCajeros.getElementsByTagName("tbody")[0];
    filaCajeros = tbodyCajeros.getElementsByTagName("tr");

    tablaClientes = document.getElementById('clientes');
    tbodyClientes = tablaClientes.getElementsByTagName("tbody")[0];
    filaClientes = tbodyClientes.getElementsByTagName("tr");

    trsCuentas = document.getElementsByClassName("datosDeCuenta");

    tablaTransacciones = document.getElementById('transacciones');
    tbodyTransacciones = tablaTransacciones.getElementsByTagName("tbody")[0];
    filaTransacciones = tbodyTransacciones.getElementsByTagName("tr");


    Array.from(filaGerentes).map((fila, i) => {
        var unArray = [];
        miCelda = fila.getElementsByTagName("td");
        Array.from(miCelda).map((celda, o) => {
            if (celda.style.color !== 'red') {
                unArray.push(celda.textContent);
            }
        });
        var moment = {codigo: unArray[0], nombre: unArray[1], turno: unArray[2], dpi: unArray[3], direccion: unArray[4], sexo: unArray[5], password: unArray[6]};
        gerentes.push(moment);
    });

    Array.from(filaCajeros).map((fila, i) => {
        var unArray = [];
        miCelda = fila.getElementsByTagName("td");
        Array.from(miCelda).map((celda, o) => {
            if (celda.style.color !== 'red') {
                unArray.push(celda.textContent);
            }
        });
        var moment = {codigo: unArray[0], nombre: unArray[1], turno: unArray[2], dpi: unArray[3], direccion: unArray[4], sexo: unArray[5], password: unArray[6]};
        cajeros.push(moment);
    });

    Array.from(filaClientes).map((fila, i) => {
        if (fila.className === 'filaCliente') {
            var unArray = [];
            miCelda = fila.getElementsByTagName("td");
            Array.from(miCelda).map((celda, o) => {
                unArray.push(celda.textContent);
            });
            var moment = {codigo1: unArray[0], nombre: unArray[1], dpi: unArray[2], fecha: unArray[4], direccion: unArray[5], sexo: unArray[6], password: unArray[7]};
            clientes.push(moment);
        }
    });

    Array.from(trsCuentas).map((fila, i) => {
        var unArray = [];
        miCelda = fila.getElementsByTagName("td");
        Array.from(miCelda).map((celda, o) => {
            if (celda.style.color !== 'red') {
                if (o === 0) {
                    unArray.push(celda.id);
                }
                unArray.push(celda.textContent);
            }
        });
        var moment = {cliente: unArray[0], codigo: unArray[1], monto: unArray[2], fecha: unArray[3]};
        cuentas.push(moment);
    });

    Array.from(filaTransacciones).map((fila, i) => {
        var unArray = [];
        miCelda = fila.getElementsByTagName("td");
        Array.from(miCelda).map((celda, o) => {
            unArray.push(celda.textContent);
        });
        var moment = {codigo: unArray[0], cuenta: unArray[1], fecha: unArray[2], hora: unArray[3], tipo: unArray[4], monto: unArray[5], cajero: unArray[6]};
        console.log(moment);
        transacciones.push(moment);
    });

    $("#actualSubiendo").text("Subiendo gerentes...");
    $.ajax({
        type: 'POST', // it's easier to read GET request parameters
        url: '../carga',
        data: {
            tipo: 1,
            test: JSON.stringify(gerentes)
        },
        success: function (data) {
            if (data.length > 0)
            {
                cambiandoProgreso(1 / 6, "Subiendo cajeros...");
                cambiando(data, "resultadosGerente", "Gerentes");
                $.ajax({
                    type: 'POST', // it's easier to read GET request parameters
                    url: '../carga',
                    data: {
                        tipo: 2,
                        test: JSON.stringify(cajeros)
                    },
                    success: function (data) {
                        if (data.length > 0) {
                            cambiandoProgreso(2 / 6, "Subiendo clientes...");
                            cambiando(data, "resultadosCajero", "Cajeros");
                            $.ajax({
                                type: 'POST', // it's easier to read GET request parameters
                                url: '../carga',
                                data: {
                                    tipo: 3,
                                    contentType: "application/json; charset=utf-8",
                                    test: JSON.stringify(clientes)
                                },
                                success: function (data) {
                                    if (data.length > 0) {
                                        cambiandoProgreso(3 / 6, "Subiendo cuentas...");
                                        cambiando(data, "resultadosCliente", "Clientes");
                                        $.ajax({
                                            type: 'POST', // it's easier to read GET request parameters
                                            url: '../carga',
                                            data: {
                                                tipo: 4,
                                                test: JSON.stringify(cuentas)
                                            },
                                            success: function (data) {
                                                if (data.length > 0)
                                                {
                                                    cambiandoProgreso(4 / 6, "Subiendo transacciones...");
                                                    cambiando(data, "resultadosCuenta", "Cuentas");
                                                    $.ajax({
                                                        type: 'POST', // it's easier to read GET request parameters
                                                        url: '../carga',
                                                        data: {
                                                            tipo: 5,
                                                            test: JSON.stringify(transacciones)
                                                        },
                                                        success: function (data) {
                                                            if (data.length > 0)
                                                            {
                                                                cambiandoProgreso(5 / 6, "Subiendo archivos PDF...");
                                                                cambiando(data, "resultadosTransaccion", "Transacciones");
                                                                $("#prueba1").submit();
                                                            }
                                                        },
                                                        error: function (data) {
                                                            alert('Fallo al ingresar');
                                                        }
                                                    });
                                                }
                                            },
                                            error: function (data) {
                                                alert('Fallo al ingresar');
                                            }
                                        });
                                    }
                                },
                                error: function (data) {
                                    alert('Fallo al ingresar clientes');
                                }
                            });
                        }
                    },
                    error: function (data) {
                        alert('Fallo al ingresar doctores');
                    }
                });
            }
        },
        error: function (data) {
            alert('Fallo al ingresar examenes');
        }
    });

}
function verCuentas(boton) {
    var center = boton.parentNode;
    var td = center.parentNode;
    var tabla = td.querySelectorAll("table")[0];
    if (tabla.style.display === "none") {
        tabla.style.display = "";
        boton.innerHTML = "CUENTAS<img src='../resources/img/collapse.svg' width='15%' style='display: inline-block;vertical-align: middle;'>";
    } else {
        tabla.style.display = "none";
        boton.innerHTML = "CUENTAS<img src='../resources/img/expand.svg' width='15%' style='display: inline-block;vertical-align: middle;'>";
    }
}
function cerrandoFrame() {
    $("#contenedorMensaje").hide();
}

function cambiandoProgreso(valor, actualSubiendo) {
    document.getElementById('actualSubiendo').innerText = actualSubiendo;
    $('.progress').circleProgress({
        value: valor * 100
    });
}

function cambiarEstado(datos, tabla) {
    var arrayDeCadenas = datos.split(",");
    console.log(datos + " " + tabla);
    tablaDatos = document.getElementById(tabla);
    datosTabla = tablaDatos.getElementsByTagName("tbody")[0];
    filasTabla = datosTabla.getElementsByTagName("tr");
    Array.from(filasTabla).map((fila, i) => {
        miCelda = fila.getElementsByTagName("td");
        Array.from(miCelda).map((celda, o) => {
            if ((miCelda.length - 1) === o) {
                if (arrayDeCadenas[i] === "1") {
                    celda.textContent = "INGRESADO";
                    celda.style.color = "#00ff17";
                } else {
                    celda.style.color = "#ff0000";
                }
            }
        });
    });
}

function cambiando(datos, clase, nombreT) {
    var nuevos = datos.split("\n");
    var permitidos = ["clientes", "cajeros", "transacciones", "gerentes"];
    var ingresados = 0;
    var contador = 0;
    var tabla = document.querySelector('#historial > tbody');
    for (let nuevo of nuevos) {
        if (nuevo.length > 0) {
            const tr = document.createElement('tr');
            tr.className = clase;
            tr.style.display = "none";
            const REGISTRO = document.createElement('td');
            const ESTADO = document.createElement('td');
            const RETORNO = document.createElement('td');
            if (nuevo.includes("-")) {
                var estado = nuevo.split("-");
                REGISTRO.textContent = estado[0];
                ESTADO.textContent = "ERROR: " + estado[1];
                ESTADO.style.color = "red";
                tr.style.display = "";
                $("#historialContenedor").fadeIn(1000);
            } else {
                ESTADO.textContent = "INGRESADO";
                ESTADO.style.color = "green";
                ingresados++;
            }
            if (nuevo.includes("ID")) {
                var id = nuevo.split("ID:");
                REGISTRO.textContent = id[0];
                RETORNO.textContent = id[1];
            } else {
                RETORNO.textContent = "----";
            }
            REGISTRO.style.color = "grey";
            RETORNO.style.color = "grey";
            if (!nuevo.includes("ID") && !nuevo.includes("-")) {
                REGISTRO.textContent = nuevo;
            }
            if (permitidos.includes(nombreT.toLowerCase())) {
                if (nombreT.toLowerCase() !== "clientes") {
                    var editando = document.querySelector("#" + nombreT.toLowerCase() + " > tbody");
                    var filas = editando.querySelectorAll("tr")[contador];
                    var campos = filas.querySelectorAll("td");
                    console.log(campos.length);
                    var celda = campos[campos.length - 1];
                    if (RETORNO.textContent === '----') {
                        celda.textContent = ESTADO.textContent;
                    } else {
                        celda.textContent = ESTADO.textContent + " - USUARIO: " + RETORNO.textContent;
                    }
                    celda.style.color = ESTADO.style.color;
                } else {
                    var filas = document.getElementsByClassName("filaCliente")[contador];
                    var campos = filas.querySelectorAll("td");
                    console.log(campos.length);
                    var celda = campos[campos.length - 1];
                    if (RETORNO.textContent === '----') {
                        celda.textContent = ESTADO.textContent;
                    } else {
                        celda.textContent = ESTADO.textContent + " - USUARIO: " + RETORNO.textContent;
                    }
                    celda.style.color = ESTADO.style.color;
                }
            }
            tr.append(REGISTRO, ESTADO, RETORNO);
            tabla.appendChild(tr);
            contador++;
        }
    }
    var resumen = document.querySelector('#resumen > tbody');
    const tr = document.createElement('tr');
    tr.className = clase;
    const INGRESADOS = document.createElement('td');
    const TABLA = document.createElement('td');
    var totales = nuevos.length - 1;
    INGRESADOS.textContent = totales + "/" + ingresados;
    TABLA.textContent = nombreT;
    tr.append(INGRESADOS, TABLA);
    resumen.appendChild(tr);
    $("#resumenContenedor").fadeIn(1000);
}

function cerrandoFrame() {
    $("#iniciarSesion").show();
    $("#opciones").css("grid-template-columns","auto auto auto");
    $("#contenedorMensaje").hide();
}