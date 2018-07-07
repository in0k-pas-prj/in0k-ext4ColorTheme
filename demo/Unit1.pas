unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  csc_sRGB_2_HSV,
  csc_sRGB_2_Lab,
  csc_HSV_2_sRGB,

  LCLType,

  in0k_ext4ColorTheme_maker, Classes, SysUtils, FileUtil, Forms, Controls,
  Graphics, Dialogs, ColorBox, StdCtrls, ExtCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button10: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    ColorBox1: TColorBox;
    ColorListBox1: TColorListBox;
    ColorListBox2: TColorListBox;
    Memo1: TMemo;
    Shape1: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    procedure Button10Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure ColorBox1Change(Sender: TObject);
    procedure ColorListBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure Colors2ColorListBox(const Colors:tExt4ColorTheme_Colors; const ColorListBox:TColorListBox);
  public
    { public declarations }
    colors:tExt4ColorTheme_Colors;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender:TObject);
begin
    Ext4ColorTheme_Colors__INI(colors);
    //
    {Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clHighlight));
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clHighlightedText));
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clHighlightText));

    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clHotLight));


    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clBackground              ));
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clActiveCaption           ));
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clInactiveCaption         ));
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clMenu                    ));//: Ne));    ));
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clWindow                  ));//: NewColorName := rsWindowColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clWindowFrame             ));//: NewColorName := rsWindowFrameColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clMenuText                ));//: NewColorName := rsMenuTextColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clWindowText              ));//: NewColorName := rsWindowTextColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clCaptionText             ));//: NewColorName := rsCaptionTextColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clActiveBorder            ));//: NewColorName := rsActiveBorderColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clInactiveBorder          ));//: NewColorName := rsInactiveBorderColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clAppWorkspace            ));//: NewColorName := rsAppWorkspaceColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clHighlight               ));//: NewColorName := rsHighlightColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clHighlightText           ));//: NewColorName := rsHighlightTextColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clBtnFace                 ));//: NewColorName := rsBtnFaceColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clBtnShadow               ));//: NewColorName := rsBtnShadowColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clGrayText                ));//: NewColorName := rsGrayTextColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clBtnText                 ));//: NewColorName := rsBtnTextColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clInactiveCaptionText     ));//: NewColorName := rsInactiveCaptionText;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clBtnHighlight            ));//: NewColorName := rsBtnHighlightColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(cl3DDkShadow              ));//: NewColorName := rs3DDkShadowColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(cl3DLight                 ));//: NewColorName := rs3DLightColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clInfoText                ));//: NewColorName := rsInfoTextColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clInfoBk                  ));//: NewColorName := rsInfoBkColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clHotLight                ));//: NewColorName := rsHotLightColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clGradientActiveCaption   ));//: NewColorName := rsGradientActiveCaptionColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clGradientInactiveCaption ));//: NewColorName := rsGradientInactiveCaptionColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clMenuHighlight           ));//: NewColorName := rsMenuHighlightColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clMenuBar                 ));//: NewColorName := rsMenuBarColorCaption;
    Ext4ColorTheme_Colors__addProduce(colors,ColorToRGB(clForm                    ));//: NewColorName := rsFormColorCaption;
    }
    Ext4ColorTheme_Colors__addProduce_sysColors(colors, eE4CT_PM__Normal);
    Colors2ColorListBox(colors,ColorListBox1);
   // Screen.f;



end;

procedure TForm1.ColorListBox1Click(Sender: TObject);
begin

end;

procedure TForm1.Colors2ColorListBox(const Colors:tExt4ColorTheme_Colors; const ColorListBox:TColorListBox);
var tmp:pointer;
    clr:tColor;
begin
    ColorListBox.Items.BeginUpdate;
    //
    ColorListBox.Clear;
    tmp:=Ext4ColorTheme_Colors__enumFirst(colors);
    while Assigned(tmp) do begin
        clr:=Ext4ColorTheme_Colors__enumColor(tmp);
        ColorListBox.Items.AddObject('#'+IntToHex(clr,6)+' '+FloatToStr(Ext4ColorTheme_Colors__enumDelta(tmp)),tObject(clr));
        tmp:=Ext4ColorTheme_Colors__enumNext(tmp);
    end;
    //
    ColorListBox.Items.EndUpdate;
    Caption:=inttostr(ColorListBox1.Items.Count);
end;


procedure TForm1.Button1Click(Sender: TObject);
var tmp:pointer;
      c:tColor;
begin
    ColorListBox1.Clear;

    tmp:=Ext4ColorTheme_Colors__enumFirst(colors);
    while Assigned(tmp) do begin
        c:=Ext4ColorTheme_Colors__enumColor(tmp);
        ColorListBox1.Items.AddObject('#'+IntToHex(c,6)+' '+FloatToStr(Ext4ColorTheme_Colors__enumDelta(tmp)),tObject(c));
        tmp:=Ext4ColorTheme_Colors__enumNext(tmp);
    end;

    Caption:=inttostr(ColorListBox1.Items.Count);
end;

procedure TForm1.Button10Click(Sender: TObject);
var i:integer;
  clr:tColor;
var  H,S,V:Single;
     r,g,b:byte;
     t:string;
begin
    for i:=0 to MAX_SYS_COLORS do begin
        clr:=TColor(SYS_COLOR_BASE or i);

        t:=ColorToString(clr);

        ColorListBox2.AddItem(ColorToString(clr),TObject(clr));

       // ();
        clr:=ColorToRGB(clr);
        sRGB_2_HSV( Red(clr),Green(clr),Blue(clr),H,S,V);

        //t:=t+' h='+FloatToStr(H)+' s='+FloatToStr(s)+' v='+FloatToStr(v)+'';
        t:=t+' '+FloatToStr(H)+' '+FloatToStr(s)+' '+FloatToStr(v)+'';
        memo1.Lines.Add(t);


    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    Ext4ColorTheme_Colors__delSimilar_sysColors(colors);
    Colors2ColorListBox(colors,ColorListBox1);
end;

procedure TForm1.Button3Click(Sender: TObject);
var  c:TColor;
var  H,S,V:Single;
     r,g,b:byte;
begin
    Ext4ColorTheme_Colors__sort(colors, ColorToRGB(ColorBox1.Selected));
    Colors2ColorListBox(colors,ColorListBox1);
    //
    c:=Ext4ColorTheme_Top(colors);
    Shape1.Brush.Color:=c;
    sRGB_2_HSV( Red(c),Green(c),Blue(c),H,S,V);

    caption:='h='+FloatToStr(H)+' s='+FloatToStr(s)+' v='+FloatToStr(v)+'';

    HSV_2_sRGB(H,1,1, r,g,b);
    c:=RGBToColor(r,g,b);
    Shape2.Brush.Color:=c;
    //


end;

procedure TForm1.Button4Click(Sender: TObject);
var  c:TColor;
var  H,S,V:Single;
     r,g,b:byte;
begin
    c:=ColorToRGB(clBtnFace);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),H,S,V);
    TButton(Sender).Caption:='clButton h='+FloatToStr(H)+' s='+FloatToStr(s)+'v='+FloatToStr(v)+'';
end;

procedure TForm1.Button5Click(Sender: TObject);
var  c:TColor;
var  H,S,V:Single;
     r,g,b:byte;
begin
    c:=ColorToRGB(clBtnShadow);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),H,S,V);
    TButton(Sender).Caption:='clBtnShadow h='+FloatToStr(H)+' s='+FloatToStr(s)+'v='+FloatToStr(v)+'';
end;

procedure TForm1.Button6Click(Sender: TObject);
var  c:TColor;
var  H,S,V:Single;
     r,g,b:byte;
begin
    c:=ColorToRGB(clBtnHighlight);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),H,S,V);
    TButton(Sender).Caption:='v h='+FloatToStr(H)+' s='+FloatToStr(s)+'v='+FloatToStr(v)+'';
end;


procedure TForm1.ColorBox1Change(Sender: TObject);
begin
    Button3.Caption:= IntToHex( ColorToRGB(ColorBox1.Selected) ,6);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    Ext4ColorTheme_Colors__DEL(colors);
end;


procedure TForm1.Button8Click(Sender: TObject);
var  wH,wS,wV:Single;
var  tH,tS,tV:Single;
var  c:TColor;
     r,g,b:byte;
begin
    c:=ColorToRGB(clWindow);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),wH,wS,wV);
    //---
    c:=ColorToRGB(Shape5.Brush.Color);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),tH,tS,tV);
    //---
    th:=wH-th;
    tS:=wS-tS;
    tV:=wV-tV;
    //
    c:=ColorToRGB(Shape2.Brush.Color);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),wH,wS,wV);

    //th:=wH-th;
    WS:=wS-tS;
    WV:=wV-tV;
    //
    HSV_2_sRGB( wH,wS,wV, r,g,b);

    c:=RGBToColor(r,g,b);
    Shape8.Brush.Color:=c;

    //================

    c:=ColorToRGB(clWindow);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),wH,wS,wV);
    //---
    c:=ColorToRGB(Shape5.Brush.Color);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),tH,tS,tV);
    //---
    th:=wH-th;
    tS:=wS-tS;
    tV:=wV-tV;
    //
    c:=ColorToRGB(Shape2.Brush.Color);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),wH,wS,wV);

    //th:=wH-th;
    WS:=wS-tV;
    WV:=wV-ts;
    //
    HSV_2_sRGB( wH,wS,wV, r,g,b);

    c:=RGBToColor(r,g,b);
    Shape10.Brush.Color:=c;



end;

procedure TForm1.Button9Click(Sender: TObject);
var  wH,wS,wV:Single;
var  tH,tS,tV:Single;
var  c:TColor;
     r,g,b:byte;
begin
    c:=ColorToRGB(clWindow);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),wH,wS,wV);
    //---
    c:=ColorToRGB(Shape6.Brush.Color);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),tH,tS,tV);
    //---
    th:=wH-th;
    tS:=wS-tS;
    tV:=wV-tV;
    //
    c:=ColorToRGB(Shape2.Brush.Color);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),wH,wS,wV);

    //th:=wH-th;
    WS:=wS-tS;
    WV:=wV-tV;
    //
    HSV_2_sRGB( wH,wS,wV, r,g,b);

    c:=RGBToColor(r,g,b);
    Shape9.Brush.Color:=c;

    //===================

    c:=ColorToRGB(clWindow);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),wH,wS,wV);
    //---
    c:=ColorToRGB(Shape6.Brush.Color);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),tH,tS,tV);
    //---
    th:=wH-th;
    tS:=wS-tS;
    tV:=wV-tV;
    //
    c:=ColorToRGB(Shape2.Brush.Color);
    sRGB_2_HSV( Red(c),Green(c),Blue(c),wH,wS,wV);

    //th:=wH-th;
    WS:=wS-tV;
    WV:=wV-tS;
    //
    HSV_2_sRGB( wH,wS,wV, r,g,b);

    c:=RGBToColor(r,g,b);
    Shape11.Brush.Color:=c;


end;


end.

