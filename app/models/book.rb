class Book < ApplicationRecord
  #フォロー機能
  has_many :favorites, dependent: :destroy

  #コメント機能
  has_many :book_comments, dependent: :destroy

  #閲覧数
  has_many :view_counts, dependent: :destroy

  belongs_to :user
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}


  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end



def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
end
end