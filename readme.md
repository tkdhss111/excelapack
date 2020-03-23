# Excel用 BLAS／LAPACK プログラム
---
## 概要

Excelシートに入力された値をVBAで取得し，BLASやLAPACKで記述されたプログラムを実行する。
その実行結果を，Excelシートに反映するプログラム。

## 動作原理

``mermaid
sequenceDiagram

Excel VBA->>lapack.dll: ma, mb, mc, va, vb, vc 

Note left of lapack.dll:ＶＢＡデータ授受

Note right of lapack.dll:バイナリデータ授受

lapack.dll->>lapack.exe: lapack_input

Note right of lapack.exe:プログラム実行

lapack.exe->>lapack.dll: lapack_output

lapack.dll->>Excel VBA: ma, mb, mc, va, vb, vc 

``
ma: 行列A, mb:行列B,  mc:行列C,  va:ベクトルa,  vb:ベクトルb,  vc:ベクトルc  
lapack_input: lapack.exeプログラムへの入力バイナリデータ  
lapack_output: lapack.exeプログラムから出力バイナリデータ（lapack.dllへの入力バイナリデータ）



## 作成手順
1. BLAS77とLAPACK77のライブラリを作成
2. BLAS95とLAPACK95 インターフェースライブラリを作成
3. ユーザーコンソールプログラムと Excel をリンクするDLLを作成
4. Excel VBA プロシージャ・ワークシートを作成
5. BLAS/LAPACK95のユーザーコンソールプログラムを作成

手順1--3は初回のみ実施すればよい．
2回目以降は，手順4と5を実施する．

## 1. BLAS77とLAPACK77のライブラリを作成

次のインストールマニュアルとライブラリソースコードでライブラリを作成する．   
  - インストールマニュアル    
    - [LAPACK for Windows](https://icl.cs.utk.edu/lapack-for-windows/lapack/)
    - [WindowsのMinGWでlapackを使う](https://qiita.com/ryoi084/items/56ec137a58f2323bc689)

  - ライブラリソースコード  
    - [Netlib Repository (lapack.tgz)](http://netlib.org/lapack/lapack.tgz)

ビルドしたフォルダ内の**lib** フォルダ内にライブラリが作成される．  

>libblas.a  
>liblapack.a

この２つのライブラリをコピーし開発環境の **lib** 内に保存する．  
他のファイルは不要である．

## 2. BLAS95とLAPACK95 インターフェースライブラリを作成

  ソースコードは，開発環境の **lib/interfaces** 内に保存されている．  
  これらのものは，Intel Math Kernel Library（無料）から取得したもの．  
  **src** をコマンドプロンプトのカレントディレクトリにして，次のコマンドを入力してライブラリを作成する．

```make
> make lib
```
開発環境の **lib** 内に次の２つのライブラリが作成される．  
この他，6つのモジュールファイルが同フォルダ内に同時に作成される．

>libblas95.a  
>liblapack95.a

前手順で作成したライブラリと合わせて，合計４つのライブラリが作成された．  

## 3. ユーザーコンソールプログラムと Excel をリンクするDLLを作成

  ソースコード：**src/lapack_dll.f90**

```make
> make dll
```

開発環境の **bin** 内に次の２つのDLLが作成される．  

>lapack_32bit.dll  
>test_64bit.dll  

## 4. BLAS/LAPACK95のユーザーコンソールプログラムを作成

1. デバッグ用のユーザーコンソールプログラムを作成する．  

  デバッグ用プログラムは，テストデータ
  **src/set_test_data.f90** を用いたBLASやLAPACKの計算結果を
  コンソールに表示する．
  次のソースコードは，
  BLASのルーチン（gemm; 一般行列積）を実装した例である．
  行列 A (ma) x 行列 B (mb) + 行列 C (mc) を計算する．
  BLASとLAPACKのルーチンについては，**man** にあるマニュアルを参照のこと．  

 **src/lapack_sub.f90** 
```fortran
subroutine s02 ()

  call gemm ( ma, mb, mc )

end subroutine
```

**src** のディレクトリで次のコマンドを入力して，プログラムを作成する．  

```make
> make debug
```

開発環境の **bin** 内に次のコンソールプログラムが作成される．  

>debug.exe  

デバッグが終了したら本コンソールプログラムは不要である．

2. ユーザーコンソールプログラムを作成する．  

**src** のディレクトリで次のコマンドを入力して，プログラムを作成する．  

```make
> make release
```

開発環境の **bin** 内に次のコンソールプログラムが作成される．  

>lapack.exe  

このコンソールプログラムは，カレントディレクトリか Windows のパスが通った場所に保存する．

（参考）次のコマンド入力で上記の手順（lib, dll, debug, release）すべてを実行する。
```make
> make all
```
## 5. Excel VBA プロシージャ・ワークシートを作成

**bin** のディレクトリに保存されたExcel実装例を参考にしてExcelプロシージャやワークシートを作成してください。 

Excel VBAのモジュールファイルに記載されたDLLインターフェース

```excel
Private Declare PtrSafe Sub lapack Lib "lapack_32bit.dll" ( _
  isub As Long, _
  a1 As Long, b1 As Long, c1 As Long, _
  a2 As Long, b2 As Long, c2 As Long, _
  a3 As Long, b3 As Long, c3 As Long, _
  ma As Double, mb As Double, mc As Double, _
  va As Double, vb As Double, vc As Double)
```

プロシージャ（サブルーチンや関数）内で次のようにコール

```excel
  Call lapack( _
              isub, _
              a1, b1, c1, _
              a2, b2, c2, _
              a3, b3, c3, _
              ma(1, 1), mb(1, 1), mc(1, 1), _
              va(1), vb(1), vc(1))
```

以 上  
