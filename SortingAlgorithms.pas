unit SortingAlgorithms;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.Generics.Defaults;

type
  TSortingAlgorithms<T> = class
  private
    class procedure MergeSortInternal(var arr: TArray<T>; left, right: Integer;
      const Comparer: IComparer<T>);
    class procedure QuickSortInternal(var arr: TArray<T>; left, right: Integer;
      const Comparer: IComparer<T>);
    class procedure Merge(var arr: TArray<T>; left, middle, right: Integer;
      const Comparer: IComparer<T>);
  public
    class procedure BubbleSort(var arr: TArray<T>; const Comparer: IComparer<T>);
    class procedure MergeSort(var arr: TArray<T>; const Comparer: IComparer<T>);
    class procedure QuickSort(var arr: TArray<T>; const Comparer: IComparer<T>);
    class procedure InsertionSort(var arr: TArray<T>; const Comparer: IComparer<T>);
  end;

implementation

{ TSortingAlgorithms<T> }

class procedure TSortingAlgorithms<T>.BubbleSort(var arr: TArray<T>;
  const Comparer: IComparer<T>);
var
  I, J : Integer;
  temp : T;
begin
  for I := Low(arr) to High(arr) - 1 do
    for J := Low(arr) to High(arr) - I - 1 do
      if Comparer.Compare(arr[J], arr[J + 1]) > 0 then
      begin
        temp       := arr[J];
        arr[J]     := arr[J + 1];
        arr[J + 1] := temp;
      end;
end;

class procedure TSortingAlgorithms<T>.InsertionSort(var arr: TArray<T>;
  const Comparer: IComparer<T>);
var
  I, J : Integer;
  key : T;
begin
  for I := 1 to High(arr) do
  begin
    key := arr[I];
    J := I - 1;
    while (J >= 0) and (Comparer.Compare(arr[J], key) > 0) do
    begin
      arr[J + 1] := arr[J];
      Dec(J);
    end;
    arr[J + 1] := key;
  end;
end;

class procedure TSortingAlgorithms<T>.Merge(var arr: TArray<T>; left, middle, right: Integer;
  const Comparer: IComparer<T>);
var
  I, J, K : Integer;
  leftArray, rightArray : TArray<T>;
  leftSize, rightSize : Integer;
begin
  leftSize := middle - left + 1;
  rightSize := right - middle;

  SetLength(leftArray, leftSize);
  SetLength(rightArray, rightSize);

  // Copiar datos a los arrays temporales
  for I := 0 to leftSize - 1 do
    leftArray[I] := arr[left + I];
  for J := 0 to rightSize - 1 do
    rightArray[J] := arr[middle + 1 + J];

  // Combinar los arrays temporales
  I := 0;
  J := 0;
  K := left;

  while (I < leftSize) and (J < rightSize) do
  begin
    if Comparer.Compare(leftArray[I], rightArray[J]) <= 0 then
    begin
      arr[K] := leftArray[I];
      Inc(I);
    end
    else
    begin
      arr[K] := rightArray[J];
      Inc(J);
    end;
    Inc(K);
  end;

  // Copiar elementos restantes si hay
  while I < leftSize do
  begin
    arr[K] := leftArray[I];
    Inc(I);
    Inc(K);
  end;

  while J < rightSize do
  begin
    arr[K] := rightArray[J];
    Inc(J);
    Inc(K);
  end;
end;

class procedure TSortingAlgorithms<T>.MergeSort(var arr: TArray<T>;
  const Comparer: IComparer<T>);
begin
  if Length(arr) <= 1 then
    Exit;
  MergeSortInternal(arr, Low(arr), High(arr), Comparer);
end;

class procedure TSortingAlgorithms<T>.MergeSortInternal(var arr: TArray<T>;
  left, right: Integer; const Comparer: IComparer<T>);
var
  middle: Integer;
begin
  if left < right then
  begin
    middle := left + (right - left) div 2;
    MergeSortInternal(arr, left, middle, Comparer);
    MergeSortInternal(arr, middle + 1, right, Comparer);
    Merge(arr, left, middle, right, Comparer);
  end;
end;

class procedure TSortingAlgorithms<T>.QuickSort(var arr: TArray<T>;
  const Comparer: IComparer<T>);
begin
  if Length(arr) <= 1 then
    Exit;
  QuickSortInternal(arr, Low(arr), High(arr), Comparer);
end;

class procedure TSortingAlgorithms<T>.QuickSortInternal(var arr: TArray<T>;
  left, right: Integer; const Comparer: IComparer<T>);
var
  I, J : Integer;
  pivot, temp : T;
begin
  I := left;
  J := right;
  pivot := arr[(left + right) div 2];

  while I <= J do
  begin
    while Comparer.Compare(arr[I], pivot) < 0 do
      Inc(I);
    while Comparer.Compare(arr[J], pivot) > 0 do
      Dec(J);

    if I <= J then
    begin
      temp   := arr[I];
      arr[I] := arr[J];
      arr[J] := temp;
      Inc(I);
      Dec(J);
    end;
  end;

  if left < J then
    QuickSortInternal(arr, left, J, Comparer);
  if I < right then
    QuickSortInternal(arr, I, right, Comparer);
end;

{

// Para ordenar números:
var
  numbersArray: TArray<Integer>;
begin
  SetLength(numbersArray, 5);
  numbersArray[0] := 5;
  numbersArray[1] := 2;
  numbersArray[2] := 8;
  numbersArray[3] := 1;
  numbersArray[4] := 9;

  TSortingHelper.BubbleSort<Integer>(numbersArray, CompareInteger);
end;

// Para ordenar cadenas:
var
  stringsArray: TArray<string>;
begin
  SetLength(stringsArray, 4);
  stringsArray[0] := 'Zebra';
  stringsArray[1] := 'Ardilla';
  stringsArray[2] := 'Perro';
  stringsArray[3] := 'Gato';

  TSortingHelper.BubbleSort<string>(stringsArray, CompareString);
end;

}


end.
