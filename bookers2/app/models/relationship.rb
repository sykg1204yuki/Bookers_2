class Relationship < ApplicationRecord
  
  belongs_to :follower, class_name:"User"
  belongs_to :followed, class_name:"User"
  # class_name:"User"を定義することでUserテーブルのレコードを参照
  
end
