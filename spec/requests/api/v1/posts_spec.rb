require 'rails_helper'
describe 'Post' do
  let!(:user) { create(:user) }
  let(:header) { authenticate(user) }

  describe 'Index' do
    let!(:post) { create(:post) }

    it 'the post attributes are the same' do
      get '/api/posts', headers: header, as: :json
      json = JSON.parse(response.body)
      expect(json.first['title']).to eq(post.title)
    end
  end

  describe 'Create' do
    post_params = {
      'post': {
        'title': 'Hot news',
        'body': 'Invasion',
        'username': 'Kenny'
      }
    }

    it 'should be "Hot news"' do
      post '/api/posts', headers: header, params: post_params, as: :json
      expect(Post.first.title).to eq 'Hot news'
    end
  end

  describe 'Update' do
    let!(:post) { create(:post) }

    post_params = {
      'post': {
        'title': 'Cold news'
      }
    }

    it 'should be "Cold news"' do
      put "/api/posts/#{post.id}", headers: header, params: post_params, as: :json
      expect(Post.find(post.id).title).to eq 'Cold news'
    end
  end

  describe 'Delete' do
    let!(:post) { create(:post) }

    it "shouldn't any records" do
      delete "/api/posts/#{post.id}", headers: header, as: :json
      expect(Post.count).to eq 0
    end
  end
end
