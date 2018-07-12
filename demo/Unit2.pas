unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  math,
  cs_types, csc_sRGB_2_HSV, csc_HSV_2_sRGB, cs_W3_WCAG_contrastRatio, Classes,
  SysUtils, FileUtil, TAGraph, TASources, TASeries, TAMultiSeries, TAFuncSeries,
  TAGUIConnectorAggPas, Forms, Controls, Graphics, Dialogs, StdCtrls, ComboEx,
  ColorBox, ExtCtrls, HColorPicker, TACustomSource, TAGUIConnectorBGRA;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    cls_grayText: TLineSeries;
    cls_windowText: TLineSeries;
    cls_Window: TLineSeries;
    cls_Form: TLineSeries;
    cls_D: TLineSeries;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    HColorPicker1: THColorPicker;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LCS_Form: TListChartSource;
    LCS_GrayText: TListChartSource;
    LCS_Window: TListChartSource;
    LCS_Text: TListChartSource;
    ListChartSource1: TListChartSource;
    ListChartSource3: TListChartSource;
    LCS_D: TListChartSource;
    Shape1: TShape;
    UserDefinedChartSource1: TUserDefinedChartSource;
    procedure Button1Click(Sender: TObject);
    procedure Chart1AfterDrawBackground(ASender: TChart; ACanvas: TCanvas;
      const ARect: TRect);
    procedure Chart1AfterDrawBackWall(ASender: TChart; ACanvas: TCanvas;
      const ARect: TRect);
    procedure Chart1AfterPaint(ASender: TChart);
    procedure Chart1BeforeDrawBackground(ASender: TChart; ACanvas: TCanvas;
      const ARect: TRect; var ADoDefaultDrawing: Boolean);
    procedure Chart1BeforeDrawBackWall(ASender: TChart; ACanvas: TCanvas;
      const ARect: TRect; var ADoDefaultDrawing: Boolean);
    procedure ColorBox1Change(Sender: TObject);
    procedure HColorPicker1Change(Sender: TObject);
  private
    mcH,mcS,mcV:t_HSV_colorComp;
  private
    procedure _lcsD_make_(const LCS:TListChartSource);
  private
    function  seriesCLC_startPoint(const base,clr:TColor):Single;
    procedure seriesCLC_vLOB(const ChartSource:TListChartSource; const base,clr:TColor; const ratio:Single);
    procedure seriesCLC_vLB1(const ChartSource:TListChartSource; const base,clr:TColor; const ratio:Single);
    procedure seriesCLC(const ChartSource:TListChartSource; const base,clr:TColor; const ratio:Single);
  public

  end;

var
  Form2: TForm2;



//function calcHSV_byS(const clr:tColor; const ratio:single; const HSV_H:t_HSV_colorComp; out hsvS,hsvV):boolean;

implementation


procedure clcColor(const color:tColor; out H,s,v:t_HSV_colorComp);
var c:tcolor;
begin
   c:=ColorToRGB(color);
   sRGB_2_HSV(Red(c),Green(c),Blue(c), H,s,v);
end;

function clcColor(const H,s,v:t_HSV_colorComp):tColor;
var r,g,b:t_sRGB_colorComp;
begin
    HSV_2_sRGB(H,s,v,  r,g,b);
    result:=RGBToColor(r,g,b);
end;




function clcRatio(const clr:tColor; const H,s,v:t_HSV_colorComp):single;
begin
    result:=cs_W3WCAG_contrastRatio(clr,clcColor(H,s,v));
end;

function calcHSV_byS(const color:tColor; const ratio:single; const H:t_HSV_colorComp; out S:t_HSV_colorComp; const V:t_HSV_colorComp):boolean;
var
 tmpZ,tmpV:single;
 minZ,minV:single;
 maxZ,maxV:single;
begin
    //--- считаем для 0
    minZ:=0;
    minV:=clcRatio(color,H,minZ,V);
    //--- считаем для 1
    maxZ:=1;
    maxV:=clcRatio(color,H,maxZ,V);
    //--- проверим СУЩЕСТВОВАНИЕ решения
    result:=(min(minV,maxV)<ratio) AND (ratio<max(minV,maxV));
    if not result then EXIT; // решения НЕТ !
    //
    if maxV<minV then begin //< переворачиваем при необходимости
        tmpV:=maxV;
        tmpZ:=maxZ;
        maxV:=minV;
        maxZ:=minZ;
        minV:=tmpV;
        minZ:=tmpZ;
    end;
    //
    while not SameValue(minZ,maxZ) do begin
        tmpZ:=(minZ+maxZ)/2;
        tmpV:=clcRatio(color,H,tmpZ,V);
        //
        if tmpV<ratio then begin
            minV:=tmpV;
            minZ:=tmpZ;
        end
        else begin
            maxV:=tmpV;
            maxZ:=tmpZ;
        end;
    end;
    //
    S:=tmpZ;
end;

function calcHSV_byV(const color:tColor; const ratio:single; const H:t_HSV_colorComp; const S:t_HSV_colorComp; out V:t_HSV_colorComp):boolean;
var
 tmpZ,tmpV:single;
 minZ,minV:single;
 maxZ,maxV:single;
begin
    //--- считаем для 0
    minZ:=0;
    minV:=clcRatio(color,H,S,minZ);
    //--- считаем для 1
    maxZ:=1;
    maxV:=clcRatio(color,H,S,maxZ);
    //--- проверим СУЩЕСТВОВАНИЕ решения
    result:=(min(minV,maxV)<ratio) AND (ratio<max(minV,maxV));
    if not result then EXIT; // решения НЕТ !
    //
    if maxV<minV then begin //< переворачиваем при необходимости
        tmpV:=maxV;
        tmpZ:=maxZ;
        maxV:=minV;
        maxZ:=minZ;
        minV:=tmpV;
        minZ:=tmpZ;
    end;
    //
    while not SameValue(minZ,maxZ) do begin
        tmpZ:=(minZ+maxZ)/2;
        tmpV:=clcRatio(color,H,S,tmpZ);
        //
        if tmpV<ratio then begin
            minV:=tmpV;
            minZ:=tmpZ;
        end
        else begin
            maxV:=tmpV;
            maxZ:=tmpZ;
        end;
    end;
    //
    V:=tmpZ;
end;


{$R *.lfm}

{ TForm2 }

procedure TForm2._lcsD_make_(const LCS:TListChartSource);
begin
    LCS.BeginUpdate;
    LCS.Clear;
    //-------------------
    LCS.Add(0,0);
    LCS.Add(1,1);
    //-------------------
    LCS.EndUpdate;
end;



const _cDLT_=0.01;
const _cDLTy_=0.001;

function TForm2.seriesCLC_startPoint(const base,clr:TColor):Single;
var bH,bS,bV:t_HSV_colorComp;
    cR,cG,cB:byte;
         tst:tColor;
         dm :Single;
         d  :Single;
         r  :Single;
begin
    sRGB_2_HSV(Red(base),Green(base),Blue(base), bH,bS,bV);
    //
    d:=0;
    dm:=100;
    result:=d;
    while d<1 do begin
        HSV_2_sRGB(bH,d,d, cR,cG,cB);
        tst:=RGBToColor(cR,cG,cB);
        r:=cs_W3WCAG_contrastRatio(tst,clr);
        if r<dm then begin
            dm    :=r;
            result:=d;
        end;
        //
        d:=_cDLT_+d;
    end;
end;

procedure TForm2.seriesCLC_vLOB(const ChartSource:TListChartSource; const base,clr:TColor; const ratio:Single);
var bH,bS,bV:t_HSV_colorComp;
    cR,cG,cB:byte;
         tst:tColor;
         r  :Single;
begin
    ChartSource.BeginUpdate;
    ChartSource.Clear;
    //-------------------
    sRGB_2_HSV(Red(base),Green(base),Blue(base), bH,bS,bV);
    //
    bS:=0;
    while bS<1 do begin
        bV:=0;
        while bv<1 do begin
            HSV_2_sRGB(bH,bS,bV, cR,cG,cB);
            tst:=RGBToColor(cR,cG,cB);
            r:=cs_W3WCAG_contrastRatio(tst,clr);
            //
            if R<ratio then begin
                ChartSource.Add(bS,bv);
            end;
            //
            bv:=_cDLT_+bv;
        end;
        bS:=_cDLT_+bS;
    end;
    //--------------------------
    ChartSource.EndUpdate;
end;


procedure TForm2.seriesCLC_vLB1(const ChartSource:TListChartSource; const base,clr:TColor; const ratio:Single);
var bH,bS,bV:t_HSV_colorComp;
    cR,cG,cB:byte;
         tst:tColor;
         r  :Single;
         rd :Single;
         b:boolean;
begin
    ChartSource.BeginUpdate;
    ChartSource.Clear;
    //-------------------
    sRGB_2_HSV(Red(base),Green(base),Blue(base), bH,bS,bV);
    //
    bS:=0;
    while bS<1 do begin
        bV:=0;

            HSV_2_sRGB(bH,bS,bV, cR,cG,cB);
            tst:=RGBToColor(cR,cG,cB);
            rd:=cs_W3WCAG_contrastRatio(tst,clr);
            b:=rd<ratio;

            bv:=_cDLTy_+bv;



        while bv<1 do begin
            HSV_2_sRGB(bH,bS,bV, cR,cG,cB);
            tst:=RGBToColor(cR,cG,cB);
            r:=cs_W3WCAG_contrastRatio(tst,clr);
            //
            if b then begin
                if r>ratio then begin
                    ChartSource.Add(bS,bv);
                    break;
                end;
            end
            else begin
                if r<ratio then begin
                    ChartSource.Add(bS,bv);
                    break;
                end;
            end;

             //
            bv:=_cDLTy_+bv;
        end;
        bS:=_cDLT_+bS;
    end;
    //--------------------------
    ChartSource.EndUpdate;
end;


procedure TForm2.seriesCLC(const ChartSource:TListChartSource; const base,clr:TColor; const ratio:Single);
var //clr    :tColor;
   bH,bS,bV:t_HSV_colorComp;
   cR,cG,cB:byte;
    d:Single;
   dm:Single;
    c:Single;
begin
    LCS_Form.BeginUpdate;
    LCS_Form.Clear;
    //-------------------
    c:=seriesCLC_startPoint(base,clr);
    //
    LCS_Form.Add(  C,C,'C');




    {


    sRGB_2_HSV(Reg(base),Green(base),Blue(base), bH,bS,bV);
    //
    d:=0;
    dm:=100;
    result:=d;
    while d<1 do begin
        HSV_2_sRGB(Reg(base),Green(base),Blue(base), cR,cG,cB);
        clr:=RGBToColor(cR,cG,cB);
        r:=

        //
        d:=_cDLT_+d;
    end;   }
    //--------------------------
    LCS_Form.EndUpdate;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
   _lcsD_make_(LCS_D);
    seriesCLC_vLB1(LCS_Form    , ColorToRGB(ColorBox1.Selected),ColorToRGB(clForm), 3);
    seriesCLC_vLB1(LCS_Window  , ColorToRGB(ColorBox1.Selected),ColorToRGB(clWindow), 3);
    seriesCLC_vLB1(LCS_Text    , ColorToRGB(ColorBox1.Selected),ColorToRGB(clWindowText), 4.5);
    seriesCLC_vLB1(LCS_GrayText, ColorToRGB(ColorBox1.Selected),ColorToRGB(clGrayText),3);

  {  LCS_Form.BeginUpdate;
    LCS_Form.Clear;
    //
    LCS_Form.Add(0,0);
    LCS_Form.Add(1,1);
    LCS_Form.Add(3,3);
    LCS_Form.Add(3,-3);
    LCS_Form.Add(1,-3);
    LCS_Form.Add(0,0);

    //
    LCS_Form.EndUpdate;  }













end;

procedure TForm2.Chart1AfterDrawBackground(ASender: TChart; ACanvas: TCanvas;
  const ARect: TRect);
begin
  //
end;

procedure TForm2.Chart1AfterDrawBackWall(ASender: TChart; ACanvas: TCanvas;
  const ARect: TRect);
begin
  //
end;

procedure TForm2.Chart1AfterPaint(ASender: TChart);
begin
  //
end;

procedure TForm2.Chart1BeforeDrawBackground(ASender: TChart; ACanvas: TCanvas;
  const ARect: TRect; var ADoDefaultDrawing: Boolean);
var i,j:integer;


begin
    //ADoDefaultDrawing :=false;
    {for i:=ARect.Left to ARect.Right-1 do
      for j:=ARect.Top to ARect.Bottom-1 do
        begin
            canvas.Pixels[i,j]:=clred;
        end;}
end;

procedure TForm2.Chart1BeforeDrawBackWall(ASender: TChart; ACanvas: TCanvas;
  const ARect: TRect; var ADoDefaultDrawing: Boolean);
var i,j:integer;
    rct:TRect;
      c:tColor;
  r,g,b:byte;
begin
    ADoDefaultDrawing :=false;
    //
    rct.Left  :=max(ASender.XGraphToImage(0),ARect.Left);
    rct.Right :=min(ASender.XGraphToImage(1),ARect.Right);
    rct.Top   :=max(ASender.YGraphToImage(1),ARect.Top);
    rct.Bottom:=min(ASender.YGraphToImage(0),ARect.Bottom);
    //
    for i:=rct.Left to rct.Right-1 do
      for j:=rct.Top to rct.Bottom-1 do
        begin
            HSV_2_sRGB(mcH, ASender.XImageToGraph(i), ASender.yImageToGraph(j), R,G,B);
            ACanvas.Pixels[i,j]:=RGBToColor(R,G,B);
        end;


 {   i:=ASender.XGraphToImage(0);
    j:=ASender.YGraphToImage(0);

    ACanvas.Pixels[i,j]:=clBlue;    }












end;

procedure TForm2.ColorBox1Change(Sender: TObject);
var C:tColor;
begin
    C:=ColorToRGB(TColorBox(Sender).Selected);
    sRGB_2_HSV(Red(C),Green(C),Blue(C), mcH,mcS,mcV);
end;

procedure TForm2.HColorPicker1Change(Sender: TObject);
var lh,ls,lv:Single;
var th,ts,tv:Single;
  c:tColor;
begin
  ColorBox1.Selected:=HColorPicker1.SelectedColor;
  Button1.Click;

  clcColor(ColorBox1.Selected, lH,lV,lS);
    ListChartSource1.Clear;

    c:=ColorToRGB(clForm);
    if calcHSV_byS(c, 3,  lH,ls,1) then begin
//        Shape1.Brush.Color:=clcColor(lH,ls,1);
        ListChartSource1.Add(ls,1,'clForm');
        lv:=1;
    end
   else
    if calcHSV_byV(c, 3,  lH,1,lV) then begin
//        Shape1.Brush.Color:=clcColor(lH,1,lv);
        ListChartSource1.Add(1,lV,'clForm');
        ls:=1;
    end;

   c:=ColorToRGB(clWindowText);
   if calcHSV_byS(c, 4.5,  lH,ts,1) then begin
//       label7.font.Color:=clcColor(lH,ts,1);
       ListChartSource1.Add(ts,1,'clForm');
       tv:=1;
   end
  else
   if calcHSV_byV(c, 4.5,  lH,1,tV) then begin
//       label7.font.Color:=clcColor(lH,1,tv);
       ListChartSource1.Add(1,tV,'clForm');
       ts:=1;
   end;

   label7.font.Color:=clcColor(lH,(ls+ts)/2,(lv+tv)/2);


end;

end.

