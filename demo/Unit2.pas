unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  cs_types, csc_sRGB_2_HSV, csc_HSV_2_sRGB, cs_W3_WCAG_contrastRatio, Classes,
  SysUtils, FileUtil, TAGraph, TASources, TASeries, TAMultiSeries, TAFuncSeries,
  Forms, Controls, Graphics, Dialogs, StdCtrls, ComboEx, ColorBox;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    Chart1LineSeries2: TLineSeries;
    ColorBox1: TColorBox;
    ColorBox2: TColorBox;
    ColorBox3: TColorBox;
    Label1: TLabel;
    Label2: TLabel;
    ListChartSource1: TListChartSource;
    ListChartSource2: TListChartSource;
    RandomChartSource1: TRandomChartSource;
    procedure Button1Click(Sender: TObject);
  private
    function  seriesCLC_startPoint(const base,clr:TColor):Single;
    procedure seriesCLC_vLOB(const ChartSource:TListChartSource; const base,clr:TColor; const ratio:Single);
    procedure seriesCLC(const ChartSource:TListChartSource; const base,clr:TColor; const ratio:Single);
  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

const _cDLT_=0.01;

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

    seriesCLC_vLOB(ListChartSource1, ColorToRGB(ColorBox1.Selected),ColorToRGB(ColorBox2.Selected), 3);
    seriesCLC_vLOB(ListChartSource2, ColorToRGB(ColorBox1.Selected),ColorToRGB(ColorBox3.Selected), 3);

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

end.

