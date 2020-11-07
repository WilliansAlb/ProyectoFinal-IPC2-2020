let opciones = ['GERENTES', 'CAJEROS', 'CLIENTES', 'TRANSACCIONES'];
let posiciones = 0;
function verificar() {
    const file = document.getElementById("archivo").files[0];
    const file1 = document.getElementById("archivo");
    if (!file) {
        alert("NECESITAS SELECCIONAR UN ARCHIVO XML PRIMERO");
    } else {
        document.getElementById('ruta').innerText = ".." + file1.value.slice(12);
        document.getElementById('selectorArchivo').style.display = "none";
        document.getElementById("opciones").style.display = "grid";
        document.getElementById("ingresarDatos").style.display = "none";
        document.getElementById("verificarDatos").style.display = "";
        $('#ver').prop('disabled', false);
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
    
}
function moverIzquierda() {
    if (posiciones == 1) {
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
    if (posiciones == (opciones.length - 2)) {
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
    const file = document.getElementById("archivo").files[0];

    if (!file) {
        alert("NECESITAS SELECCIONAR UN ARCHIVO XML PRIMERO");
    } else {
        readDoc(file).then(parseDoc).then(showDocInTable).catch(onError);
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
        tr.append(CODIGO, NOMBRE, TURNO, DPI, DIRECCION, SEXO, PASSWORD,ESTADO);
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
        const CUENTASDATOS = document.createElement("td");
        const ESTADO = document.createElement("td");
        if (CUENTAS !== null) {
            const LISTADOC = CUENTAS.querySelectorAll("CUENTA");
            if (LISTADOC.length > 0) {
                CUENTASDATOS.innerHTML = '<center><button class="learn-more buttonEspecial" onclick="verCuentas(this)">CUENTAS<img src="../resources/img/expand.svg" width="15%" style="display: inline-block;vertical-align: middle;"></button></center>';
                CUENTASDATOS.innerHTML += '<table class="table-fill cuentas" style="display: none;"><thead><tr><th>Cuenta</th><th>Credito</th><th>Fecha creación</th></tr></thead><tbody>';
                CUENTASDATOS.innerHTML += '</tbody></table>';
                const tbody23 = CUENTASDATOS.querySelectorAll("table")[0];
                const tbody2 = tbody23.querySelectorAll("tbody")[0];
                for (let i = 0; i < LISTADOC.length; i++) {
                    const tr2 = document.createElement('tr');
                    var cod = LISTADOC[i].querySelector("CODIGO").textContent;
                    var cre = LISTADOC[i].querySelector("CREDITO").textContent;
                    var fec = LISTADOC[i].querySelector("CREADA").textContent;
                    const td1 = document.createElement("td");
                    const td2 = document.createElement("td");
                    const td3 = document.createElement("td");
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
        tr.append(CODIGO, NOMBRE, DPI, BIRTH, DIRECCION, SEXO, PASSWORD,CUENTASDATOS,ESTADO);
        table2.appendChild(tr);
    });
    Array.from(transacciones).map((transaccion, i) => {
        console.log(i);
        const tr = document.createElement('tr');
        const CODIGO = tagToData(transaccion.querySelector('CODIGO'));
        const CUENTA = tagToData(transaccion.querySelector('CUENTA'));
        const FECHA = tagToData(transaccion.querySelector('FECHA'));
        const HORA = tagToData(transaccion.querySelector('HORA'));
        const TIPO = tagToData(transaccion.querySelector('TIPO'));
        const MONTO = tagToData(transaccion.querySelector('MONTO'));
        const CAJEROT = tagToData(transaccion.querySelector('CAJEROT'));
        const ESTADO = document.createElement("td");
        ESTADO.textContent = "SIN INGRESAR";
        tr.append(CODIGO, CUENTA, FECHA, HORA, TIPO, MONTO, CAJEROT,ESTADO);
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
        $('#mensaje').offset({ top: 0 });
    } else {
        $('#mensaje').offset({ top: 0 });
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
    const td = document.createElement('td')
    if (tag != null) {
        td.textContent = tag.textContent;
        if (td.textContent === ''){
            td.style.backgroundColor = "red";
        }
    } else {
        td.textContent = '';
        td.style.backgroundColor = "red";
    }
    return td
}

function onError(reason) {
    console.error(reason)
}

jQuery(function ($) {
    $('.progress').circleProgress();
    $('.progress').circleProgress({
        max: 100,
        value: 0,
        textFormat: 'percent',
    });
});

function subir(range) {
    const val = range.value;
    var cp = document.getElementById('pro');
    cp.value = val;
    $('.progress').circleProgress({ value: val, });
    cp.style.setProperty('--progress-value', val / 100);
}

function ingresarTodo(boton) {
    boton.style.display = 'none';
    $('#cargando').fadeIn(500);
    miTabla = document.getElementById('examenes');
    miTBody = miTabla.getElementsByTagName("tbody")[0];
    miFila = miTBody.getElementsByTagName("tr");
    let longitud = miFila.length - 1;
    Array.from(miFila).map((fila, i) => {
        var unArray = [];
        miCelda = fila.getElementsByTagName("td");
        Array.from(miCelda).map((celda, o) => {
            if (o == 3) {
                miButton = celda.getElementsByTagName('button')[0];
                unArray.push(miButton.value);
            } else
                unArray.push(celda.textContent);
        });
        document.getElementById('actualSubiendo').innerText = "Ingresando " + unArray[0] + "..."
        $('.progress').circleProgress({
            value: (i / longitud) * 25,
        });
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