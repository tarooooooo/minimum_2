# minimum

![4e34f128847d5f6efa3753c2c3eb55c7](https://user-images.githubusercontent.com/75834810/138815210-80682b3d-12b3-45d6-ab6f-f4ecbf53c44e.gif)

## サイト概要

### 「衣類管理」　× 「フリマアプリ」　で、サステナブルファッションを身近に
### ファッションの多様化による課題を解決に導くサービス
以下のような機能を追加し、衣類管理を容易にし、フリーマーケットにも簡単に出品できるサービスとなっています。
- 登録できるアイテムの制限が設けられており、新たに商品を購入する場合は手放すアイテムを選ばなければならないようになっています。
- 手放したアイテムのブランドやデザインから傾向を分析し、手放したアイテムの特徴を可視化します。
- アイテムを、購入日ごとにグラフ化し、購入履歴を管理します。
- 不要な衣類を、直接2次流通に流すことができます。

### サイトテーマ
#### 衣類管理のできるフリマアプリ

### テーマを選んだ理由
ファッション業界は、製造にかかるエネルギーの使用量や、ライフサイクルの短さなどから環境負荷が問題視されています。また、ファストファッションが流行し、飽きたらすぐに捨ててしまうということが増え、日本における衣類廃棄量は、年間100万トンになっています。
それに伴い、２次流通の市場規模の拡大や、サステナブルファッションへの関心の高まりに繋がりました。しかし、現在の取り組みだけでは、根深い衣類廃棄問題の解決は難しく、一人一人の意識の改変が必要になってくると思われます。
具体的には、しっかりと検討して購入する習慣をつけ、長く使えるものを選ぶこと、２次流通を活用し、捨てるものをできるだけ削減することが必要だとされています。minimumでは、衣類管理を容易にし、フリーマーケットにも簡単に出品できるため、「衣類管理」　×　「フリマアプリ」を実現し、身近にサステナブルファッションにアプローチできるようになっています。そして、このサービスを通して、サステナブルファッションを身近に始めていただき、少しでも衣類の環境問題の解決に導いていきたいと考え、制作しました。

### ターゲットユーザ
衣類管理がしたい方、環境問題に関心がある方、モノを大切にしたい方

### 主な利用シーン
クローゼットを可視化し、簡単に衣類管理をしたいとき
気軽に環境問題に対して、関わりたいとき
衝動買いなど、不要なものを買う習慣を断ち切りたいとき

## 使用技術
- MySQL
- nginx,puma
- Javascript・jQuery
- Ruby 2.6.6, Rails 6.0.3.2
- RSpec（テストフレームワーク）
- AWS/本番環境（EC2, RDS, VPC, EIP,ALB, IAM, S3）
- Amazon Linux

![AWS Design (updated)](https://user-images.githubusercontent.com/75834810/138829354-66ab7e26-4516-4401-8798-4b61d724f464.png)

## 設計
- ER図　：https://drive.google.com/file/d/1Qsgk4gDvy_zIwHW_ovvRhD8Gf5bMJDP9/view?usp=sharing
- UIflow図：https://drive.google.com/file/d/18xzQLs_24_bOgloQOgd88HdEnisPUKw2/view?usp=sharing
- アプリケーション詳細設計：https://docs.google.com/spreadsheets/d/1wZsuUOcoYXWnVzIyFpHCI_mLCK-xkDG5BhRWULqONtA/edit?usp=sharing
- テーブル定義書：https://docs.google.com/spreadsheets/d/1oA_e2LWHEavEOhOcD7i2UBWq1LV1Nrba/edit?usp=sharing&ouid=112847534265417995265&rtpof=true&sd=true
- スライドショー（ポートフォリオ紹介用）:https://docs.google.com/presentation/d/1Mww5t5GJJnSaletl7Y4iSXXVVAcrks5EFuLElRPEQYc/edit?usp=sharing

## チャレンジ要素一覧
https://docs.google.com/spreadsheets/d/16KIZUU0Obm4Hcp7GI9WP4_nhBXJKlH2hCMwC64ua2w8/edit?usp=sharing

## 開発環境
cOS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 作者
- 前田龍太郎
