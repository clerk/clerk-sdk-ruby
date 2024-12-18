require "erb"
require "clerk"

class App
  def call(env)
    # # Example: Without using `Clerk::Rack::Reverification` Middleware
    # preset = Clerk::StepUp::Preset::LAX
    # if env["clerk"].user_needs_reverification?(preset)
    #   return env["clerk"].user_reverification_rack_response(preset)
    # end

    respond_with(200) do
      user = env["clerk"].user
      user ? "Authenticated User: #{user.first_name} (#{user.id})" : "Not Authenticated"
    end
  end

  private

  def respond_with(status, plain_body = nil, &html_body)
    return [status, {"Content-Type" => "text/plain; charset=utf-8"}, [plain_body]] unless block_given?

    compiled = <<-HTML
      <html>
        <head>
          <title>Rack</title>
          <style>
            html { font-family: monospace; }
            @media (prefers-color-scheme: dark) {
              html {
                color: #FFE6E6FF;
                background-color: #201D1E;
              }
            }
          </style>
          <script
            async 
            crossorigin="anonymous"
            data-clerk-publishable-key="#{ENV["CLERK_PUBLISHABLE_KEY"]}"
            src="#{ENV["CLERK_JS_URL"]}"
            type="text/javascript"
          ></script>
          <script>
            window.addEventListener('load', async function () {
              await Clerk.load()
              const container = document.getElementById('auth-container')
              if (Clerk.user) {
                container.innerHTML = `<div id="user-button"></div>`
                Clerk.mountUserButton(document.getElementById('user-button'))
              } else {
                container.innerHTML = `<div id="sign-in"></div>`
                Clerk.mountSignIn(document.getElementById('sign-in'))
              }
            })
          </script>
        </head>
        <body>
          <h1>Rack</h1>
          <h2>#{yield}</h2>
          <div id="auth-container"></div>
        </body>
      </html>
    HTML

    [status, {"Content-Type" => "text/html; charset=utf-8"}, [compiled]]
  end
end
