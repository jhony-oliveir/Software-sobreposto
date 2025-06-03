^SPACE::
WinGet, ExStyle, ExStyle, A
WinGet, MinMax, MinMax, A  ; 1 = maximizada, -1 = minimizada, 0 = normal

if (MinMax = 1)  ; Se a janela estiver maximizada, não faz nada
{
    WinSet, AlwaysOnTop, Off, A
    ShowPopup("Não é possível alterar 'sempre no topo' com a janela maximizada.")
    return
}

WinGetPos, X, Y, W, H, A  ; Pega posição da janela ativa

if (ExStyle & 0x8)  ; 0x8 = WS_EX_TOPMOST
{
    WinSet, AlwaysOnTop, Off, A
    ShowPopup("A janela NÃO está mais sempre no topo.", X, Y, W, H)
}
else
{
    WinSet, AlwaysOnTop, On, A
    ShowPopup("A janela AGORA está sempre no topo.", X, Y, W, H)
}
return

ShowPopup(text, winX := 200, winY := 200, winW := 0, winH := 0) {
    Gui, Popup:Destroy  ; Garante que a GUI anterior seja fechada antes
    Gui, Popup:+AlwaysOnTop +ToolWindow -Caption +Border
    Gui, Popup:Margin, 10, 10
    Gui, Popup:Font, s30, Segoe UI
    Gui, Popup:Add, Text,, %text%

    ; Mostra no canto superior esquerdo da janela ativa
    if (winW > 0 && winH > 0) {
        ; Posiciona no canto superior esquerdo
        popupX := winX + 10  ; 10px de margem para o lado direito
        popupY := winY + 10  ; 10px de margem para baixo
        Gui, Popup:Show, AutoSize NoActivate x%popupX% y%popupY%
    } else {
        Gui, Popup:Show, AutoSize NoActivate Center
    }

    SetTimer, ClosePopup, -1500  ; Timer negativo = executa uma vez após 1.5s
    return

    ClosePopup:
    Gui, Popup:Destroy
    return
}
