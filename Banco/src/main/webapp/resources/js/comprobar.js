/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
function comprobar(input) {
    dejarDeEscribir(input);
}

let timeout;
function dejarDeEscribir(input) {
    clearTimeout(timeout);
    timeout = setTimeout(() => {
        llamarMetodoDejoDeEscribir(input);
        clearTimeout(timeout);
    }, 800);
}

