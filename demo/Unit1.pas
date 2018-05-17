unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  in0k_ext4ColorTheme_maker, Classes, SysUtils, FileUtil, Forms, Controls,
  Graphics, Dialogs, ColorBox, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ColorBox1: TColorBox;
    ColorListBox1: TColorListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
    Ext4ColorTheme_Colors__addProduce_sysColors(colors);
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

procedure TForm1.Button2Click(Sender: TObject);
begin
    Ext4ColorTheme_Colors__delSimilar_sysColors(colors);
    Colors2ColorListBox(colors,ColorListBox1);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    Ext4ColorTheme_Colors__sort(colors, ColorToRGB(ColorBox1.Selected));
    Colors2ColorListBox(colors,ColorListBox1);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    Ext4ColorTheme_Colors__DEL(colors);
end;


end.

