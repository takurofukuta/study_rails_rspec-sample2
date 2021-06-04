require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET #index" do
    subject {get(users_path)}
    context "ユーザーが存在する時" do
      before { create_list(:user, 3) }
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(:ok)
      end
      it "name が表示されている" do
        subject
        expect(response.body).to include(*User.pluck(:name))
      end
    end
  end

  describe "GET #show" do
    subject { get(user_path(user_id)) }
    context "ユーザーが存在するとき" do
      let(:user) {create(:user)}
      let(:user_id) {user.id}
      it "リクエストが成功する" do    
        subject
        expect(response).to have_http_status(:ok)
      end

      it "name が表示されている" do
        subject
        expect(response.body).to include(user.name)
      end

      it "age が表示されている" do
        subject
        expect(response.body).to include(user.age.to_s)
      end

      it "email が表示されている" do
        subject
        expect(response.body).to include(user.email)
      end
    end
    context ":idに対応するユーザーが存在しないとき" do
      let(:user_id) { 1 }
      it "エラーが発生する" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "GET #new" do
    subject { get(new_user_path) }
    it "リクエストが成功する" do
      subject
      expect(response).to have_http_status(:ok)      
    end
  end
   describe "POST #create" do
    subject { post(users_path, params: params) }
    context "パラメータが正常なとき" do
      let(:params) { { user: attributes_for(:user) } }

      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(302)
      end

      it "ユーザーが保存される" do
        expect { subject }.to change { User.count }.by(1)
      end

      it "詳細ページにリダイレクトされる" do
        subject
        expect(response).to redirect_to User.last
      end
    end

    context "パラメータが異常なとき" do
      let(:params) { { user: attributes_for(:user, :invalid) } }

      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(200)
      end

      it "ユーザーが保存されない" do
        expect { subject }.not_to change(User, :count)
      end

      it "新規投稿ページがレンダリングされる" do
        subject
        expect(response.body).to include "新規投稿"
      end
    end
  end
end
