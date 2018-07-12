unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  cs_types, csc_sRGB_2_HSV, csc_HSV_2_sRGB, cs_W3_WCAG_contrastRatio, Classes,
  SysUtils, FileUtil, TAGraph, TASources, TASeries, TAMultiSeries, TAFuncSeries,
  TAGUIConnectorAggPas, Forms, Controls, Graphics, Dialogs, StdCtrls, ComboEx,
  ColorBox;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    Chart1AreaSeries1: TAreaSeries;
    Chart1LineSeries1: TLineSeries;
    Chart1LineSeries2: TLineSeries;
    ChartGUIConnectorAggPas1: TChartGUIConnectorAggPas;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    Label1: TLabel;
    Label2: TLabel;
    ListChartSource1: TListChartSource;
    ListChartSource2: TListChartSource;
    RandomChartSource1: TRandomChartSource;
    procedure Button1Click(Sender: TObject);
    procedure Chart1AfterDrawBackWall(ASender: TChart; ACanvas: TCanvas;
      const ARect: TRect);
    procedure Chart1BeforeDrawBackground(ASender: TChart; ACanvas: TCanvas;
      const ARect: TRect; var ADoDefaultDrawing: Boolean);
    procedure Chart1BeforeDrawBackWall(ASender: TChart; ACanvas: TCanvas;
      const ARect: TRect; var ADoDefaultDrawing: Boolean);
  private
    function  seriesCLC_startPoint(const base,clr:TColor):Single;
    procedure seriesCLC_vLOB(const ChartSource:TListChartSource; const base,clr:TColor; const ratio:Single);
    procedure seriesCLC_vLB1(const ChartSource:TListChartSource; const base,clr:TColor; const ratio:Single);
    procedure seriesCLC(const ChartSource:TListChartSource; const base,clr:TColor; const ratio:Single);
  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

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
    ListChartSource1.BeginUpdate;
    ListChartSource1.Clear;
    //-------------------
    c:=seriesCLC_startPoint(base,clr);
    //
    ListChartSource1.Add(  C,C,'C');




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
    ListChartSource1.EndUpdate;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin

    seriesCLC_vLB1(ListChartSource1, ColorToRGB(ColorBox1.Selected),ColorToRGB(ColorBox2.Selected), 3);
    seriesCLC_vLB1(ListChartSource2, ColorToRGB(ColorBox1.Selected),ColorToRGB(ColorBox3.Selected), 3);

  {  ListChartSource1.BeginUpdate;
    ListChartSource1.Clear;
    //
    ListChartSource1.Add(0,0);
    ListChartSource1.Add(1,1);
    ListChartSource1.Add(3,3);
    ListChartSource1.Add(3,-3);
    ListChartSource1.Add(1,-3);
    ListChartSource1.Add(0,0);

    //
    ListChartSource1.EndUpdate;  }
end;

procedure TForm2.Chart1AfterDrawBackWall(ASender: TChart; ACanvas: TCanvas;
  const ARect: TRect);
begin

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


begin
    ADoDefaultDrawing :=false;
    for i:=ARect.Left to ARect.Right-1 do
      for j:=ARect.Top to ARect.Bottom-1 do
        begin
            ACanvas.Pixels[i,j]:=clred;
        end;

    ASender.LeftAxis.v;

end;
//end;

end.

