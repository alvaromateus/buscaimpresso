// Utilizado para permitir copiar e colar nos campos formatados
var ctrl = false;

/* 
Objetivo: Formatar a entrada do dado no input. Serve para datas, horas, datas e horas, 
cpf, cgf e outros que tenham tamanho fixo e sejam numricos. 

Atributos: 
- campo		: Campo que ser mascarado. Pode-se referenciar o campo como ele mesmo:this. 
- teclapres	: Passar event (event recebe valor da tecla que foi pressionada). 
- mascara	: ex: '##-##' (12-34)  
	
Valores aceitos na mascara: '#' e '9' (para nmeros), '-', '/', ':', ' '(branco) 
PS: - evento de chamada  onkeydown, 
	- size e maxlength tem que ser setados de acordo com a mscara,  
*/ 
function formatField(Campo,teclapres,mascara) { 
	strtext = Campo.value;
    tamtext = strtext.length; 
    //pegando o tamanho da mascara 
    tammask = mascara.length; 
    //criando um array para guardar cada caractere da mscara 
    arrmask = new Array(tammask);     
    //jogando os caracteres para o vetor 
    for (var i = 0 ; i < tammask; i++) { 
        arrmask[i] = mascara.slice(i,i+1); 
    } 
    if (teclapres.keyCode == 17) // CTRL
    	ctrl = true;  
    //inicia a formatacao 
    if (((((arrmask[tamtext] == "#") || 
    		(arrmask[tamtext] == "9"))) || 
    		(((arrmask[tamtext+1] != "#") || (arrmask[tamtext+1] != "9"))))) { 
        if ((teclapres.keyCode >= 37 && teclapres.keyCode <= 40) || // %, &, ', (
        	(teclapres.keyCode >= 48 && teclapres.keyCode <= 57) || // 0 a 9 (tecl. sup.)
        	(teclapres.keyCode >= 96 && teclapres.keyCode <= 105) || // 0 a 9 (tecl. num.)
        	(ctrl && teclapres.keyCode == 67) ||  // ctrl + c  
        	(ctrl && teclapres.keyCode == 99) ||  // ctrl + c     	
        	(ctrl && teclapres.keyCode == 86) ||  // ctrl + v
        	(ctrl && teclapres.keyCode == 118) || // ctrl + v      	
        	(teclapres.keyCode == 8) ||  // backspace
        	(teclapres.keyCode == 9) ||  // tab
        	(teclapres.keyCode == 46) || // . (ponto)
        	(teclapres.keyCode == 13)) { // Enter
            organize(Campo, arrmask[tamtext], teclapres.keyCode, strtext);
        	if ((ctrl && teclapres.keyCode == 67) ||  // ctrl + c  
        		(ctrl && teclapres.keyCode == 99) ||  // ctrl + c     	
        		(ctrl && teclapres.keyCode == 86) ||  // ctrl + v
        		(ctrl && teclapres.keyCode == 118))   // ctrl + v                    
        		ctrl = false;
        } else { // ignora outro evento
		    event.returnValue = false;
		    if (strtext != "") { 
		        Campo.value = strtext;
		    } 
        } 
    } 
}

// Mtodo utilizado com o formatField
// Organiza o campo de acordo com a mscara
function organize(Campo,arrpos,teclapres_key,strtext){ 
    if (((arrpos == "/") || 
    	 (arrpos == ".") || 
    	 (arrpos == ",") || 
    	 (arrpos == ":") || 
    	 (arrpos == " ") || 
    	 (arrpos == "-")) && 
    	 !(teclapres_key == 8)) {  // backspace 
        separador = arrpos 
        masktext = strtext + separador 
        Campo.value = masktext 
    } 
} 

// Verifica se a tecla pressionada  nmero ou no
function isNumeric(event) {
	var code;
	if (navigator.appName == "Microsoft Internet Explorer") {
		code = event.keyCode;
	} else { // Netscape
		var keyChar = String.fromCharCode(event.which);
		code = keyChar.charCodeAt(0);		
	}
	if (code > 47 && code < 58) { // nmeros
		return true; 
	} else {
		if ((code > 64 && code < 91)  || 	// letras A a Z
			(code > 96 && code < 123) || 	// letras a a z 
			(code == 231) || (code == 199) || //  e 
			(code == 180) || (code == 168) || // '' e ''
			(code > 31 && code < 48)  || 	// pontuaes
			(code > 57 && code < 65)  || 	// pontuaes
			(code > 90 && code < 97)  || 	// pontuaes
			(code > 122 && code < 127))  	// pontuaes
			return false;
		else 
			return true;
	}	
}

// Verifica se  uma data vlida
function isDate(data) { 
	if (data.value != "") {
		dia = (data.value.substring(0,2)); 
        mes = (data.value.substring(3,5)); 
        ano = (data.value.substring(6,10)); 
        situacao = ""; 
        // verifica o dia valido para cada mes 
        if ((dia < 1)||(dia < 1 || dia > 30) && (  mes == 4 || mes == 6 || mes == 9 || mes == 11 ) || dia > 31) { 
            situacao = "falsa"; 
        } 
        // verifica se o mes e valido 
        if (mes < 1 || mes > 12 ) { 
            situacao = "falsa"; 
        } 
        // verifica se e ano bissexto 
        if (mes == 2 && ( dia < 1 || dia > 29 || ( dia > 28 && (parseInt(ano / 4) != ano / 4)))) { 
            situacao = "falsa"; 
        } 
        if (situacao == "falsa") { 
            alert(data.value + ": data invlida!"); 
            data.focus(); 
        } 
	}
} 

// Limita o tamanho de um campo "textarea"
function textareaLimit(field,countfield,maxlimit) {
	if (field.value.length > maxlimit) // if too long...trim it!
		field.value = field.value.substring(0, maxlimit);
	else // otherwise, update 'characters left' counter
	countfield.innerText = maxlimit - field.value.length;
}

// Desabilita todos os campos do formulrio recebido por parmetro
// usage: <form method="POST" onSubmit="submitAndDisable(this)">
function submitAndDisable(theform) {
//if IE 4+ or NS 6+
	if (document.all||document.getElementById) {
		for (i=0;i<theform.length;i++) {
			var tempobj=theform.elements[i];
			if(tempobj.type.toLowerCase()=="submit"||
			tempobj.type.toLowerCase()=="button"||
			tempobj.type.toLowerCase()=="reset")
				tempobj.disabled=true;
		}
	}
	return true;
}

// Foca o primeiro elemento do formulrio
function focusFirst() {
   if (document.forms.length > 0) {
      var TForm = document.forms[0];
      for (i=0;i<TForm.length;i++) {
         if ((TForm.elements[i].type=="text")||
           (TForm.elements[i].type=="textarea")||
           (TForm.elements[i].type.toString().charAt(0)=="s")) {
            document.forms[0].elements[i].focus();
            break;
         }
      }
   }
}
