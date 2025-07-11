Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "role_users/create"
      get "role_users/destroy"
      # Devise Token Auth（ユーザー認証）
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
        sessions: 'api/v1/auth/sessions'
      }

      # 認証関連の追加ルート
      namespace :auth do
        resources :sessions, only: %i[index]
      end

      # ユーザー関連
      resources :users, only: %i[index show update destroy] do
        # ユーザーに紐づくシフト（一覧・作成）
        resources :shifts, only: %i[create]
        # ユーザーに紐づくロール（一覧）
        resources :roles, only: %i[index], controller: 'role_users'
      end


      # シフト個別操作（取得・更新・削除）
      resources :shifts, only: %i[index show update destroy]

      # ユーザー特定のシフトを取得するためのカスタムルート
      get '/shifts/specific/:id', to: 'shifts#show_specific', as: 'specific_shift'
      
      # ロール管理
      resources :roles, only: %i[index show create update destroy]

      # ロールとユーザーの関連付け管理
      resources :role_users, only: [:create, :destroy]
    end
  end
end
