; Script para simular una escritura en camara rapida de un texto ya escrito.
; Para utilizar el script hay que seleccionar el contenido que se quiere simular,
; copiarlo al portapapeles, despues ejecutar el script en una ventana nueva del editor deseado.

^!v:: ; Se ejecuta con "Ctrl + Alt + v"

#SingleInstance Force ; Fueza a sobreescribir la instancia anterior del script.

myClipboard := clipboard ; Guarda los datos del portapapeles a una variable.
numSpacesPerTab := 2 ; Cambiar esta variable para modificar la cantidad de espacios que representa un tab.

If !Trim(myClipboard) { ; Comprobamos que haya datos en el portapapeles.
	MsgBox, "No hay elementos en el portapapeles, copie el contenido deseado y vuelva a intentarlo."
	Return
}

StringReplace, myClipboard, myClipboard, `r`n, `n, All ; Eliminamos los saltos de linea sobrantes.
StringReplace, myClipboard, myClipboard, {A_Space %numSpacesPerTab%}, `t, All ; Formateamos los tabuladores para que aparezcan bien escritos  

clipboardArray := StrSplit(myClipboard, "`n")

For index, line in clipboardArray {
	pos := RegExMatch(line, "\S")
	newLine := line . "`n"
	SendRaw, %newLine% ;Enviamos los datos en secuendcia.
	If (pos > 1) {
		backTimes := pos - 1
		Send, {BackSpace %backTimes%}
	}
}

Esc::ExitApp  ; Terminar la App de emergencia
