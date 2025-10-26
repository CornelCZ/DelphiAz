unit uLocalisedText;

{ This unit contains UK/US localised text. Note that an attempt was made to convert Product Modelling to use
  resource dlls for this purpose but the resource dll for the LineEdit form reported errors on opening.
  There was no time to resolve this issue at the time but it would be good if we could for constencies sake. }

interface

var
  PrintStreamText : string;
  ProductModellingTextName: String;
  ProductModellingAppName: String;
  RecipeModellingText: String;

procedure InitialiseLocalisedText;

implementation

uses uGlobals;

const
  PRINT_STREAM_UK = 'Print Stream';
  PRINT_STREAM_US = 'Print Group';
  PRODUCT_MODELLING_TEXTNAME_UK = 'Product Modelling';
  PRODUCT_MODELLING_TEXTNAME_US = 'Product Modeling';
  PRODUCT_MODELLING_APPNAME_UK = 'ProductModelling';
  PRODUCT_MODELLING_APPNAME_US = 'ProductModeling';
  RECIPE_MODELLING_TEXTNAME_UK = 'Recipe Modelling';
  RECIPE_MODELLING_TEXTNAME_US = 'Recipe Modeling';

procedure InitialiseLocalisedText;
begin
  if uGlobals.UKUSMode = 'UK' then
  begin
    PrintStreamText := PRINT_STREAM_UK;
    ProductModellingTextName := PRODUCT_MODELLING_TEXTNAME_UK;
    ProductModellingAppName := PRODUCT_MODELLING_APPNAME_UK;
    RecipeModellingText := RECIPE_MODELLING_TEXTNAME_UK;
  end
  else
  begin
    PrintStreamText := PRINT_STREAM_US;
    ProductModellingTextName := PRODUCT_MODELLING_TEXTNAME_US;
    ProductModellingAppName := PRODUCT_MODELLING_APPNAME_US;
    RecipeModellingText := RECIPE_MODELLING_TEXTNAME_US;
  end;
end;

end.
