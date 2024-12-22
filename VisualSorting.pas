unit VisualSorting;

{
    ** Algoritmos de Ordenamiento para Componentes Visuales **

  LIBRERIA PARA APLICAR LOS ALGORITMOS DE ORDENAMIENTO A LOS COMPONENTES
  VISUALES Memo, ListBox, ComboBox, CheckListBox, RichEdit, TreeView y ListView.

  HASTA AHORA SE USA CON LOS COMPONENTES DEVELOPER EXPRESS PERO SE PUEDE ADAPTAR
  A LOS COMPONENTES ESTANDAR DE DELPHI SIMPLEMENTE CAMBIANDOLE EL NOMBRE DE LA
  CLASE DEL COMPONENTE EN LOS PARAMETROS DE LOS PROCEDIMIENTOS.

}


interface

uses
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.CheckLst, System.Classes,
  cxGraphics, cxControls, cxContainer, cxEdit, cxTreeView, cxTextEdit, cxMemo,
  cxCustomListBox, cxListBox, cxMaskEdit, cxDropDownEdit, cxCheckBox,
  cxCheckListBox, cxListView, cxLookAndFeels,
  cxLookAndFeelPainters,  cxCheckComboBox, cxInplaceContainer;


type
  TVisualSortHelper = class
  public
    // Métodos para Memo
    class procedure SortMemo(Memo : TcxMemo); overload;
    class procedure SortMemoReverse(Memo : TcxMemo);

    // Métodos para ListBox
    class procedure SortListBox(ListBox : TcxListBox); overload;
    class procedure SortListBoxReverse(ListBox : TcxListBox);

    // Métodos para ComboBox
    class procedure SortComboBox(ComboBox : TcxComboBox); overload;
    class procedure SortComboBoxReverse(ComboBox : TcxComboBox);

    // Métodos para CheckListBox
    class procedure SortCheckListBox(CheckListBox : TcxCheckListBox); overload;
    class procedure SortCheckListBoxReverse(CheckListBox : TcxCheckListBox);

    // Métodos para TreeView
    class procedure SortTreeViewNode(TreeView : TcxTreeView; Node : TTreeNode);
    class procedure SortTreeViewNodeReverse(TreeView : TcxTreeView; Node : TTreeNode);

    // Métodos para ListView
    class procedure SortListView(ListView : TcxListView; Column : Integer); overload;
    class procedure SortListViewReverse(ListView : TcxListView; Column : Integer);
  end;

implementation

uses
  System.SysUtils, System.Generics.Collections, System.Generics.Defaults;

{ Helpers para mantener estados }
type
  TCheckListBoxItem = record
    Text    : string;
    Checked : Boolean;
  end;

  TListViewItem = record
    MainText : string;
    SubItems : TStringList;
  end;

{ Implementación para TMemo }
class procedure TVisualSortHelper.SortMemo(Memo : TcxMemo);
var
  Lines: TStringList;
begin
  Lines := TStringList.Create;
  try
    Lines.Assign(Memo.Lines);
    Lines.Sort;
    Memo.Lines.Assign(Lines);
  finally
    Lines.Free;
  end;
end;

class procedure TVisualSortHelper.SortMemoReverse(Memo : TcxMemo);
var
  Lines    : TStringList;
  I        : Integer;
  TempList : TStringList;
begin
  Lines := TStringList.Create;
  TempList := TStringList.Create;
  try
    Lines.Assign(Memo.Lines);
    Lines.Sort;
    // Invertir el orden
    for I := Lines.Count - 1 downto 0 do
      TempList.Add(Lines[I]);
    Memo.Lines.Assign(TempList);
  finally
    Lines.Free;
    TempList.Free;
  end;
end;

{ Implementación para TListBox }
class procedure TVisualSortHelper.SortListBox(ListBox : TcxListBox);
var
  Items : TStringList;
begin
  Items := TStringList.Create;
  try
    Items.Assign(ListBox.Items);
    Items.Sort;
    ListBox.Items.Assign(Items);
  finally
    Items.Free;
  end;
end;

class procedure TVisualSortHelper.SortListBoxReverse(ListBox : TcxListBox);
var
  Items, TempList : TStringList;
  I : Integer;
begin
  Items    := TStringList.Create;
  TempList := TStringList.Create;
  try
    Items.Assign(ListBox.Items);
    Items.Sort;
    for I:= Items.Count - 1 downto 0 do
      TempList.Add(Items[I]);
    ListBox.Items.Assign(TempList);
  finally
    Items.Free;
    TempList.Free;
  end;
end;

{ Implementación para TComboBox }
class procedure TVisualSortHelper.SortComboBox(ComboBox : TcxComboBox);
var
  Items        : TStringList;
  SelectedItem : string;
begin
  Items := TStringList.Create;
  try
    SelectedItem := ComboBox.Text;
    Items.Assign(ComboBox.Properties.Items);
    Items.Sort;
    ComboBox.Properties.Items.Assign(Items);
    ComboBox.Text := SelectedItem; // Mantener la selección
  finally
    Items.Free;
  end;
end;

class procedure TVisualSortHelper.SortComboBoxReverse(ComboBox : TcxComboBox);
var
  Items, TempList : TStringList;
  SelectedItem : string;
  I : Integer;
begin
  Items    := TStringList.Create;
  TempList := TStringList.Create;
  try
    SelectedItem := ComboBox.Text;
    Items.Assign(ComboBox.Properties.Items);
    Items.Sort;
    for I:= Items.Count - 1 downto 0 do
      TempList.Add(Items[I]);
    ComboBox.Properties.Items.Assign(TempList);
    ComboBox.Text := SelectedItem; // Mantener la selección
  finally
    Items.Free;
    TempList.Free;
  end;
end;

{ Implementación para TCheckListBox }
{
class procedure TVisualSortHelper.SortCheckListBox(CheckListBox : TCheckListBox);
var
  i: Integer;
  Items: TList<TCheckListBoxItem>;
  Item: TCheckListBoxItem;
begin
  Items := TList<TCheckListBoxItem>.Create;
  try
    // Guardar items y estados
    for i := 0 to CheckListBox.Items.Count - 1 do
    begin
      Item.Text := CheckListBox.Items[i];
      Item.Checked := CheckListBox.Checked[i];
      Items.Add(Item);
    end;

    // Ordenar usando comparador personalizado
    Items.Sort(TComparer<TCheckListBoxItem>.Construct(
      function(const Left, Right: TCheckListBoxItem): Integer
      begin
        Result := CompareText(Left.Text, Right.Text);
      end));

    // Restaurar items ordenados
    CheckListBox.Items.BeginUpdate;
    try
      CheckListBox.Items.Clear;
      for i := 0 to Items.Count - 1 do
      begin
        CheckListBox.Items.Add(Items[i].Text);
        CheckListBox.Checked[i] := Items[i].Checked;
      end;
    finally
      CheckListBox.Items.EndUpdate;
    end;
  finally
    Items.Free;
  end;
end;

class procedure TVisualSortHelper.SortCheckListBoxReverse(CheckListBox : TCheckListBox);
var
  i: Integer;
  Items: TList<TCheckListBoxItem>;
  Item: TCheckListBoxItem;
begin
  Items := TList<TCheckListBoxItem>.Create;
  try
    // Guardar items y estados
    for i := 0 to CheckListBox.Items.Count - 1 do
    begin
      Item.Text := CheckListBox.Items[i];
      Item.Checked := CheckListBox.Checked[i];
      Items.Add(Item);
    end;

    // Ordenar usando comparador personalizado inverso
    Items.Sort(TComparer<TCheckListBoxItem>.Construct(
      function(const Left, Right: TCheckListBoxItem): Integer
      begin
        Result := CompareText(Right.Text, Left.Text);
      end));

    // Restaurar items ordenados
    CheckListBox.Items.BeginUpdate;
    try
      CheckListBox.Items.Clear;
      for i := 0 to Items.Count - 1 do
      begin
        CheckListBox.Items.Add(Items[i].Text);
        CheckListBox.Checked[i] := Items[i].Checked;
      end;
    finally
      CheckListBox.Items.EndUpdate;
    end;
  finally
    Items.Free;
  end;
end;
}


{ Implementación para TcxCheckListBox }
class procedure TVisualSortHelper.SortCheckListBox(CheckListBox : TcxCheckListBox);
var
  I : Integer;
  Items : TList<TCheckListBoxItem>;
  Item  : TCheckListBoxItem;
begin
  Items := TList<TCheckListBoxItem>.Create;
  try
    // Guardar items y estados
    for I:= 0 to CheckListBox.Items.Count - 1 do
    begin
      Item.Text    := CheckListBox.Items[I].Text;
      Item.Checked := CheckListBox.Items[I].Checked;
      Items.Add(Item);
    end;

    // Ordenar usando comparador personalizado
    Items.Sort(TComparer<TCheckListBoxItem>.Construct(
      function(const Left, Right : TCheckListBoxItem) : Integer
      begin
        Result := CompareText(Left.Text, Right.Text);
      end));

    // Restaurar items ordenados
    CheckListBox.Items.BeginUpdate;
    try
      CheckListBox.Items.Clear;
      for I:= 0 to Items.Count - 1 do
      begin
        with CheckListBox.Items.Add do
        begin
          Text    := Items[I].Text;
          Checked := Items[I].Checked;
        end;
      end;
    finally
      CheckListBox.Items.EndUpdate;
    end;
  finally
    Items.Free;
  end;
end;

class procedure TVisualSortHelper.SortCheckListBoxReverse(CheckListBox : TcxCheckListBox);
var
  I : Integer;
  Items : TList<TCheckListBoxItem>;
  Item  : TCheckListBoxItem;
begin
  Items := TList<TCheckListBoxItem>.Create;
  try
    // Guardar items y estados
    for I:= 0 to CheckListBox.Items.Count - 1 do
    begin
      Item.Text    := CheckListBox.Items[I].Text;
      Item.Checked := CheckListBox.Items[I].Checked;
      Items.Add(Item);
    end;

    // Ordenar usando comparador personalizado inverso
    Items.Sort(TComparer<TCheckListBoxItem>.Construct(
      function(const Left, Right : TCheckListBoxItem) : Integer
      begin
        Result := CompareText(Right.Text, Left.Text);
      end));

    // Restaurar items ordenados
    CheckListBox.Items.BeginUpdate;
    try
      CheckListBox.Items.Clear;
      for I:= 0 to Items.Count - 1 do
      begin
        with CheckListBox.Items.Add do
        begin
          Text    := Items[I].Text;
          Checked := Items[I].Checked;
        end;
      end;
    finally
      CheckListBox.Items.EndUpdate;
    end;
  finally
    Items.Free;
  end;
end;

{ Implementación para TTreeView }
class procedure TVisualSortHelper.SortTreeViewNode(TreeView : TcxTreeView; Node : TTreeNode);
var
  NodeList : TList<TTreeNode>;
  I : Integer;
  CurrentNode : TTreeNode;
begin
  if not Assigned(Node) then
    Exit;

  // Ordenar los hijos del nodo actual
  NodeList := TList<TTreeNode>.Create;
  try
    // Recopilar nodos hijos
    CurrentNode := Node.getFirstChild;
    while Assigned(CurrentNode) do
    begin
      NodeList.Add(CurrentNode);
      CurrentNode := CurrentNode.getNextSibling;
    end;

    // Ordenar nodos
    NodeList.Sort(TComparer<TTreeNode>.Construct(
      function(const Left, Right : TTreeNode) : Integer
      begin
        Result := CompareText(Left.Text, Right.Text);
      end));

    // Reordenar nodos en el árbol
    TreeView.Items.BeginUpdate;
    try
      for I:= 0 to NodeList.Count - 1 do
      begin
        NodeList[I].MoveTo(Node, naAddChild);
        // Ordenar recursivamente los subárboles
        SortTreeViewNode(TreeView, NodeList[I]);
      end;
    finally
      TreeView.Items.EndUpdate;
    end;
  finally
    NodeList.Free;
  end;
end;

class procedure TVisualSortHelper.SortTreeViewNodeReverse(TreeView : TcxTreeView; Node : TTreeNode);
var
  NodeList : TList<TTreeNode>;
  I : Integer;
  CurrentNode : TTreeNode;
begin
  if not Assigned(Node) then
    Exit;

  NodeList := TList<TTreeNode>.Create;
  try
    CurrentNode := Node.getFirstChild;
    while Assigned(CurrentNode) do
    begin
      NodeList.Add(CurrentNode);
      CurrentNode := CurrentNode.getNextSibling;
    end;

    NodeList.Sort(TComparer<TTreeNode>.Construct(
      function(const Left, Right : TTreeNode) : Integer
      begin
        Result := CompareText(Right.Text, Left.Text);
      end));

    TreeView.Items.BeginUpdate;
    try
      for I:= 0 to NodeList.Count - 1 do
      begin
        NodeList[I].MoveTo(Node, naAddChild);
        SortTreeViewNodeReverse(TreeView, NodeList[I]);
      end;
    finally
      TreeView.Items.EndUpdate;
    end;
  finally
    NodeList.Free;
  end;
end;

{ Implementación para TListView }
class procedure TVisualSortHelper.SortListView(ListView : TcxListView; Column : Integer);
var
  I, J : Integer;
  Items : TList<TListItem>;
begin
  Items := TList<TListItem>.Create;
  try
    // Recopilar items
    for I:= 0 to ListView.Items.Count - 1 do
      Items.Add(ListView.Items[I]);

    // Ordenar usando comparador personalizado
    Items.Sort(TComparer<TListItem>.Construct(
      function(const Left, Right : TListItem) : Integer
      begin
        if Column = 0 then
          Result := CompareText(Left.Caption, Right.Caption)
        else if Column <= Left.SubItems.Count then
          Result := CompareText(Left.SubItems[Column-1], Right.SubItems[Column-1])
        else
          Result := 0;
      end));

    // Reordenar items
    ListView.Items.BeginUpdate;
    try
      for I:= 0 to Items.Count - 1 do
      begin
        with ListView.Items.Add do
        begin
          Caption := Items[I].Caption;
          for J:= 0 to Items[I].SubItems.Count - 1 do
            SubItems.Add(Items[I].SubItems[J]);
        end;
      end;

      // Eliminar items originales
      while ListView.Items.Count > Items.Count do
        ListView.Items[0].Delete;
    finally
      ListView.Items.EndUpdate;
    end;
  finally
    Items.Free;
  end;
end;

class procedure TVisualSortHelper.SortListViewReverse(ListView : TcxListView; Column : Integer);
var
  I, J : Integer;
  Items : TList<TListItem>;
begin
  Items := TList<TListItem>.Create;
  try
    for I:= 0 to ListView.Items.Count - 1 do
      Items.Add(ListView.Items[I]);

    Items.Sort(TComparer<TListItem>.Construct(
      function(const Left, Right : TListItem) : Integer
      begin
        if Column = 0 then
          Result := CompareText(Right.Caption, Left.Caption)
        else if Column <= Left.SubItems.Count then
          Result := CompareText(Right.SubItems[Column-1], Left.SubItems[Column-1])
        else
          Result := 0;
      end));

    ListView.Items.BeginUpdate;
    try
      for I:= 0 to Items.Count - 1 do
      begin
        with ListView.Items.Add do
        begin
          Caption := Items[I].Caption;
          for J:= 0 to Items[I].SubItems.Count - 1 do
            SubItems.Add(Items[I].SubItems[J]);
        end;
      end;

      while ListView.Items.Count > Items.Count do
        ListView.Items[0].Delete;
    finally
      ListView.Items.EndUpdate;
    end;
  finally
    Items.Free;
  end;
end;

{

// Para un TMemo
TVisualSortHelper.SortMemo(Memo1);
// Orden inverso
TVisualSortHelper.SortMemoReverse(Memo1);

// Para un TListBox
TVisualSortHelper.SortListBox(ListBox1);
// Orden inverso
TVisualSortHelper.SortListBoxReverse(ListBox1);

// Para un TComboBox
TVisualSortHelper.SortComboBox(ComboBox1);
// Orden inverso
TVisualSortHelper.SortComboBoxReverse(ComboBox1);

// Para un TCheckListBox
TVisualSortHelper.SortCheckListBox(CheckListBox1);
// Orden inverso
TVisualSortHelper.SortCheckListBoxReverse(CheckListBox1);

// Para un TTreeView (ordena a partir de un nodo)
TVisualSortHelper.SortTreeViewNode(TreeView1, TreeView1.Items[0]);
// Orden inverso
TVisualSortHelper.SortTreeViewNodeReverse(TreeView1, TreeView1.Items[0]);

// Para un TListView (ordena por columna)
TVisualSortHelper.SortListView(ListView1, 0); // 0 para la primera columna
// Orden inverso
TVisualSortHelper.SortListViewReverse(ListView1, 0);


}

end.
