require 'rails_helper'
describe 'Post' do
  let!(:user) { create(:user) }
  let(:header) { authenticate(user) }

  describe 'Index' do

    it 'the post attributes are the same' do
      post = create(:post)
      get '/api/v2/posts', headers: header
      json = JSON.parse(response.body)
      expect(json['data'][0]['attributes']['title']).to eq(post.title)
    end

    it 'sort created_at DESC' do
      10.times { FactoryGirl.create(:post) }
      post = Post.order('created_at DESC').first
      get_params = { sort: '-created_at' }
      get '/api/v2/posts', headers: header, params: get_params
      json = JSON.parse(response.body)
      expect(json['data'][0]['attributes']['title']).to eq(post.title)
    end

    it 'search is working' do
      posts = 20.times { create(:post) }
      get_params = { search: '26' }
      get '/api/v2/posts', headers: header, params: get_params
      json = JSON.parse(response.body)
      expect(json['data'][0]['attributes']['title']).to eq('Hot news 26')
    end

    it 'paginate' do
      posts = 15.times { create(:post) }
      get_params = { page: { number: 2 } }
      get '/api/v2/posts', headers: header, params: get_params
      json = JSON.parse(response.body)
      expect(json['data'].size).to eq(5)
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
      post '/api/v2/posts', headers: header, params: post_params
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
      put "/api/v2/posts/#{post.id}", headers: header, params: post_params
      expect(Post.find(post.id).title).to eq 'Cold news'
    end
  end

  describe 'Delete' do
    let!(:post) { create(:post) }

    it "shouldn't any records" do
      delete "/api/v2/posts/#{post.id}", headers: header
      expect(Post.count).to eq 0
    end
  end
end
