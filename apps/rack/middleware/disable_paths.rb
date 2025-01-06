class DisablePaths
  def initialize(app, paths: [])
    @app = app
    @paths = {}

    paths.each { |p| @paths[p] = true }
  end

  def call(env)
    return [404, {}, []] if @paths[env["PATH_INFO"]]
    @app.call(env)
  end
end
