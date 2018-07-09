require 'rails_helper'

RSpec.describe Post, type: :model do
  context "scopes" do
    let!(:post) do
      u = User.create first_name: "Jed", last_name:"bautista", middle_name:"edloja", email:"H2le@.com"
      Post.create title: "Asdf", body:"body", user: u, status: "published"
    end
    describe ".published" do
      it "returns published post" do
        
        expect(Post.published).to include post
      end

      it "does not return post that are not published" do
        post.update status: "draft"
        expect(Post.published).not_to include post
      end
    end

    describe ".draft" do
      it "returns draft post" do
        post.update status: "draft"
        expect(Post.draft).to include post
      end

      it "does not return draft" do
        expect(Post.draft).not_to include post
      end
    end
  end 
  
  context "callbacks" do
    describe ".add_title_to_body" do
      
      it "returns title and body" do
        u = User.create first_name: "Jed", last_name:"bautista", middle_name:"edloja", email:"H2le@.com"
        post = Post.create title: "title", body:"body", user: u, status: "published"
        expect(post.add_title_to_body).to eq post.body
      end
    end
  end

  context "validations" do
    let!(:x) {Post.create.errors.full_messages} 

    describe "presence" do
      it "must exist" do
        expect(x).to include "User must exist"
        expect(x).to include "Title can't be blank"
        expect(x).to include "Body can't be blank"
      end
    end

    describe "uniqueness" do
      u = User.create first_name: "Jed", last_name:"bautista", middle_name:"edloja", email:"H2le@.com"
      t = Post.create title:"Hey" ,body:"Create", user: u, status:"draft"
      m = Post.create title:"Hey", body:"Mas", user: u, status:"Ta"
      it "must be unique" do
        expect(t.title).to eq m.title
      end
    
    end

    describe "inclusions" do
      p = Post.create
      it "returns Published or Draft" do
        expect(p.status).not_to be_empty
      end
    end
  end

end
