module ActiveSupport
  def parse_json_times(); end

  def parse_json_times=(val); end

  def test_order(); end

  def test_order=(val); end

  def test_parallelization_threshold(); end

  def test_parallelization_threshold=(val); end
end

module ActiveSupport::ActionableError
end

module ActiveSupport::ActionableError::ClassMethods
  def action(name, &block); end
end

module ActiveSupport::ActionableError::ClassMethods
end

class ActiveSupport::ActionableError::NonActionable
end

class ActiveSupport::ActionableError::NonActionable
end

module ActiveSupport::ActionableError
  extend ::ActiveSupport::Concern
  def self.actions(error); end

  def self.dispatch(error, name); end
end

class ActiveSupport::ArrayInquirer
  def any?(*candidates); end
end

class ActiveSupport::ArrayInquirer
end

module ActiveSupport::Autoload
  def autoload(const_name, path=T.unsafe(nil)); end

  def autoload_at(path); end

  def autoload_under(path); end

  def eager_autoload(); end

  def eager_load!(); end
end

module ActiveSupport::Autoload
end

class ActiveSupport::BacktraceCleaner
  def add_filter(&block); end

  def add_silencer(&block); end

  def clean(backtrace, kind=T.unsafe(nil)); end

  def clean_frame(frame, kind=T.unsafe(nil)); end

  def filter(backtrace, kind=T.unsafe(nil)); end

  def remove_filters!(); end

  def remove_silencers!(); end
  FORMATTED_GEMS_PATTERN = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::BacktraceCleaner
end

module ActiveSupport::Benchmark
end

module ActiveSupport::Benchmark
  def self.realtime(unit=T.unsafe(nil), &block); end
end

module ActiveSupport::Benchmarkable
  def benchmark(message=T.unsafe(nil), options=T.unsafe(nil), &block); end
end

module ActiveSupport::Benchmarkable
end

module ActiveSupport::BigDecimalWithDefaultFormat
  def to_s(format=T.unsafe(nil)); end
end

module ActiveSupport::BigDecimalWithDefaultFormat
end

class ActiveSupport::BroadcastLogger
  include ::ActiveSupport::LoggerSilence
  include ::ActiveSupport::LoggerThreadSafeLevel
  def <<(message); end

  def add(*arg, **arg1, &arg2); end

  def broadcast_to(*loggers); end

  def broadcasts(); end

  def close(); end

  def debug(*arg, **arg1, &arg2); end

  def debug!(); end

  def debug?(); end

  def error(*arg, **arg1, &arg2); end

  def error!(); end

  def error?(); end

  def fatal(*arg, **arg1, &arg2); end

  def fatal!(); end

  def fatal?(); end

  def formatter(); end

  def formatter=(formatter); end

  def info(*arg, **arg1, &arg2); end

  def info!(); end

  def info?(); end

  def initialize(*loggers); end

  def level=(level); end

  def log(*arg, **arg1, &arg2); end

  def progname(); end

  def progname=(progname); end

  def sev_threshold=(level); end

  def silencer(); end

  def silencer=(val); end

  def stop_broadcasting_to(logger); end

  def unknown(*arg, **arg1, &arg2); end

  def warn(*arg, **arg1, &arg2); end

  def warn!(); end

  def warn?(); end
end

class ActiveSupport::BroadcastLogger
  def self.silencer(); end

  def self.silencer=(val); end
end

module ActiveSupport::Cache
  DEFAULT_COMPRESS_LIMIT = ::T.let(nil, ::T.untyped)
  OPTION_ALIASES = ::T.let(nil, ::T.untyped)
  UNIVERSAL_OPTIONS = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::Cache::Coder
  def dump(entry); end

  def dump_compressed(entry, threshold); end

  def initialize(serializer, compressor, legacy_serializer: T.unsafe(nil)); end

  def load(dumped); end
  COMPRESSED_FLAG = ::T.let(nil, ::T.untyped)
  MARSHAL_SIGNATURE = ::T.let(nil, ::T.untyped)
  OBJECT_DUMP_TYPE = ::T.let(nil, ::T.untyped)
  PACKED_EXPIRES_AT_TEMPLATE = ::T.let(nil, ::T.untyped)
  PACKED_TEMPLATE = ::T.let(nil, ::T.untyped)
  PACKED_TYPE_TEMPLATE = ::T.let(nil, ::T.untyped)
  PACKED_VERSION_INDEX = ::T.let(nil, ::T.untyped)
  PACKED_VERSION_LENGTH_TEMPLATE = ::T.let(nil, ::T.untyped)
  SIGNATURE = ::T.let(nil, ::T.untyped)
  STRING_DESERIALIZERS = ::T.let(nil, ::T.untyped)
  STRING_ENCODINGS = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::Cache::Coder::LazyEntry
  def initialize(serializer, compressor, payload, **options); end
end

class ActiveSupport::Cache::Coder::LazyEntry
end

class ActiveSupport::Cache::Coder::StringDeserializer
  def initialize(encoding); end

  def load(payload); end
end

class ActiveSupport::Cache::Coder::StringDeserializer
end

class ActiveSupport::Cache::Coder
end

class ActiveSupport::Cache::DeserializationError
end

class ActiveSupport::Cache::DeserializationError
end

class ActiveSupport::Cache::Entry
  def bytesize(); end

  def compressed(compress_threshold); end

  def compressed?(); end

  def dup_value!(); end

  def expired?(); end

  def expires_at(); end

  def expires_at=(value); end

  def initialize(value, compressed: T.unsafe(nil), version: T.unsafe(nil), expires_in: T.unsafe(nil), expires_at: T.unsafe(nil), **arg); end

  def local?(); end

  def mismatched?(version); end

  def pack(); end

  def value(); end

  def version(); end
end

class ActiveSupport::Cache::Entry
  def self.unpack(members); end
end

class ActiveSupport::Cache::FileStore
  def cache_path(); end

  def decrement(name, amount=T.unsafe(nil), **options); end

  def increment(name, amount=T.unsafe(nil), **options); end

  def initialize(cache_path, **options); end
  DIR_FORMATTER = ::T.let(nil, ::T.untyped)
  FILENAME_MAX_SIZE = ::T.let(nil, ::T.untyped)
  FILEPATH_MAX_SIZE = ::T.let(nil, ::T.untyped)
  GITKEEP_FILES = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::Cache::FileStore
  def self.supports_cache_versioning?(); end
end

class ActiveSupport::Cache::MemoryStore
  def decrement(name, amount=T.unsafe(nil), **options); end

  def increment(name, amount=T.unsafe(nil), **options); end

  def prune(target_size, max_time=T.unsafe(nil)); end

  def pruning?(); end

  def synchronize(&block); end
  PER_ENTRY_OVERHEAD = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::Cache::MemoryStore::DupCoder
  def dump(entry); end

  def dump_compressed(entry, threshold); end

  def load(entry); end
  MARSHAL_SIGNATURE = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::Cache::MemoryStore::DupCoder
  extend ::ActiveSupport::Cache::MemoryStore::DupCoder
end

class ActiveSupport::Cache::MemoryStore
  def self.supports_cache_versioning?(); end
end

class ActiveSupport::Cache::NullStore
  include ::ActiveSupport::Cache::Strategy::LocalCache
end

class ActiveSupport::Cache::NullStore
  def self.supports_cache_versioning?(); end
end

module ActiveSupport::Cache::SerializerWithFallback
  def load(dumped); end
  SERIALIZERS = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::Cache::SerializerWithFallback::Marshal70WithFallback
  include ::ActiveSupport::Cache::SerializerWithFallback
  def _load(marked); end

  def dump(entry); end

  def dump_compressed(entry, threshold); end

  def dumped?(dumped); end
  MARK_COMPRESSED = ::T.let(nil, ::T.untyped)
  MARK_UNCOMPRESSED = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::Cache::SerializerWithFallback::Marshal70WithFallback
  extend ::ActiveSupport::Cache::SerializerWithFallback::Marshal70WithFallback
  extend ::ActiveSupport::Cache::SerializerWithFallback
end

module ActiveSupport::Cache::SerializerWithFallback::Marshal71WithFallback
  include ::ActiveSupport::Cache::SerializerWithFallback
  def _load(dumped); end

  def dump(value); end

  def dumped?(dumped); end
  MARSHAL_SIGNATURE = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::Cache::SerializerWithFallback::Marshal71WithFallback
  extend ::ActiveSupport::Cache::SerializerWithFallback::Marshal71WithFallback
  extend ::ActiveSupport::Cache::SerializerWithFallback
end

module ActiveSupport::Cache::SerializerWithFallback::MessagePackWithFallback
  include ::ActiveSupport::Cache::SerializerWithFallback
  def _load(dumped); end

  def dump(value); end

  def dumped?(dumped); end
end

module ActiveSupport::Cache::SerializerWithFallback::MessagePackWithFallback
  extend ::ActiveSupport::Cache::SerializerWithFallback::MessagePackWithFallback
  extend ::ActiveSupport::Cache::SerializerWithFallback
end

module ActiveSupport::Cache::SerializerWithFallback::PassthroughWithFallback
  include ::ActiveSupport::Cache::SerializerWithFallback
  def _load(entry); end

  def dump(entry); end

  def dump_compressed(entry, threshold); end

  def dumped?(dumped); end
end

module ActiveSupport::Cache::SerializerWithFallback::PassthroughWithFallback
  extend ::ActiveSupport::Cache::SerializerWithFallback::PassthroughWithFallback
  extend ::ActiveSupport::Cache::SerializerWithFallback
end

module ActiveSupport::Cache::SerializerWithFallback
  def self.[](format); end
end

class ActiveSupport::Cache::Store
  def cleanup(options=T.unsafe(nil)); end

  def clear(options=T.unsafe(nil)); end

  def decrement(name, amount=T.unsafe(nil), options=T.unsafe(nil)); end

  def delete(name, options=T.unsafe(nil)); end

  def delete_matched(matcher, options=T.unsafe(nil)); end

  def delete_multi(names, options=T.unsafe(nil)); end

  def exist?(name, options=T.unsafe(nil)); end

  def fetch(name, options=T.unsafe(nil), &block); end

  def fetch_multi(*names); end

  def increment(name, amount=T.unsafe(nil), options=T.unsafe(nil)); end

  def initialize(options=T.unsafe(nil)); end

  def logger(); end

  def logger=(val); end

  def mute(); end

  def new_entry(value, options=T.unsafe(nil)); end

  def options(); end

  def raise_on_invalid_cache_expiration_time(); end

  def raise_on_invalid_cache_expiration_time=(val); end

  def read(name, options=T.unsafe(nil)); end

  def read_multi(*names); end

  def silence(); end

  def silence!(); end

  def silence?(); end

  def write(name, value, options=T.unsafe(nil)); end

  def write_multi(hash, options=T.unsafe(nil)); end
end

class ActiveSupport::Cache::Store
  def self.logger(); end

  def self.logger=(val); end

  def self.raise_on_invalid_cache_expiration_time(); end

  def self.raise_on_invalid_cache_expiration_time=(val); end
end

module ActiveSupport::Cache::Strategy
end

module ActiveSupport::Cache::Strategy::LocalCache
  def cleanup(options=T.unsafe(nil)); end

  def clear(options=T.unsafe(nil)); end

  def decrement(name, amount=T.unsafe(nil), **options); end

  def delete_matched(matcher, options=T.unsafe(nil)); end

  def fetch_multi(*names, &block); end

  def increment(name, amount=T.unsafe(nil), **options); end

  def middleware(); end

  def with_local_cache(&block); end
end

module ActiveSupport::Cache::Strategy::LocalCache
end

module ActiveSupport::Cache::Strategy
end

class ActiveSupport::Cache::WriteOptions
  def expires_at(); end

  def expires_at=(expires_at); end

  def expires_in(); end

  def expires_in=(expires_in); end

  def initialize(options); end

  def version(); end

  def version=(version); end
end

class ActiveSupport::Cache::WriteOptions
end

module ActiveSupport::Cache
  def self.expand_cache_key(key, namespace=T.unsafe(nil)); end

  def self.format_version(); end

  def self.format_version=(format_version); end

  def self.lookup_store(store=T.unsafe(nil), *parameters); end
end

module ActiveSupport::Callbacks
  def run_callbacks(kind, type=T.unsafe(nil)); end
  CALLBACK_FILTER_TYPES = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::Callbacks::CallTemplate
end

class ActiveSupport::Callbacks::CallTemplate::InstanceExec0
  def expand(target, value, block); end

  def initialize(block); end

  def inverted_lambda(); end

  def make_lambda(); end
end

class ActiveSupport::Callbacks::CallTemplate::InstanceExec0
end

class ActiveSupport::Callbacks::CallTemplate::InstanceExec1
  def expand(target, value, block); end

  def initialize(block); end

  def inverted_lambda(); end

  def make_lambda(); end
end

class ActiveSupport::Callbacks::CallTemplate::InstanceExec1
end

class ActiveSupport::Callbacks::CallTemplate::InstanceExec2
  def expand(target, value, block); end

  def initialize(block); end

  def inverted_lambda(); end

  def make_lambda(); end
end

class ActiveSupport::Callbacks::CallTemplate::InstanceExec2
end

class ActiveSupport::Callbacks::CallTemplate::MethodCall
  def expand(target, value, block); end

  def initialize(method); end

  def inverted_lambda(); end

  def make_lambda(); end
end

class ActiveSupport::Callbacks::CallTemplate::MethodCall
end

class ActiveSupport::Callbacks::CallTemplate::ObjectCall
  def expand(target, value, block); end

  def initialize(target, method); end

  def inverted_lambda(); end

  def make_lambda(); end
end

class ActiveSupport::Callbacks::CallTemplate::ObjectCall
end

class ActiveSupport::Callbacks::CallTemplate::ProcCall
  def expand(target, value, block); end

  def initialize(target); end

  def inverted_lambda(); end

  def make_lambda(); end
end

class ActiveSupport::Callbacks::CallTemplate::ProcCall
end

module ActiveSupport::Callbacks::CallTemplate
  def self.build(filter, callback); end
end

class ActiveSupport::Callbacks::Callback
  def apply(callback_sequence); end

  def chain_config(); end

  def compiled(); end

  def current_scopes(); end

  def duplicates?(other); end

  def filter(); end

  def initialize(name, filter, kind, options, chain_config); end

  def kind(); end

  def kind=(kind); end

  def matches?(_kind, _filter); end

  def merge_conditional_options(chain, if_option:, unless_option:); end

  def name(); end

  def name=(name); end
end

class ActiveSupport::Callbacks::Callback
  def self.build(chain, filter, kind, options); end
end

class ActiveSupport::Callbacks::CallbackChain
  include ::Enumerable
  def append(*callbacks); end

  def chain(); end

  def clear(); end

  def compile(type); end

  def config(); end

  def delete(o); end

  def each(&block); end

  def empty?(); end

  def index(o); end

  def initialize(name, config); end

  def insert(index, o); end

  def name(); end

  def prepend(*callbacks); end
end

class ActiveSupport::Callbacks::CallbackChain
end

class ActiveSupport::Callbacks::CallbackSequence
  def after(after); end

  def around(call_template, user_conditions); end

  def before(before); end

  def expand_call_template(arg, block); end

  def final?(); end

  def initialize(nested=T.unsafe(nil), call_template=T.unsafe(nil), user_conditions=T.unsafe(nil)); end

  def invoke_after(arg); end

  def invoke_before(arg); end

  def nested(); end

  def skip?(arg); end
end

class ActiveSupport::Callbacks::CallbackSequence
end

module ActiveSupport::Callbacks::ClassMethods
  def __update_callbacks(name); end

  def define_callbacks(*names); end

  def get_callbacks(name); end

  def normalize_callback_params(filters, block); end

  def reset_callbacks(name); end

  def set_callback(name, *filter_list, &block); end

  def set_callbacks(name, callbacks); end

  def skip_callback(name, *filter_list, &block); end
end

module ActiveSupport::Callbacks::ClassMethods
end

module ActiveSupport::Callbacks::Conditionals
end

class ActiveSupport::Callbacks::Conditionals::Value
  def call(target, value); end

  def initialize(&block); end
end

class ActiveSupport::Callbacks::Conditionals::Value
end

module ActiveSupport::Callbacks::Conditionals
end

module ActiveSupport::Callbacks::Filters
end

class ActiveSupport::Callbacks::Filters::After
  def apply(callback_sequence); end

  def call(env); end

  def halting(); end

  def initialize(user_callback, user_conditions, chain_config); end

  def user_callback(); end

  def user_conditions(); end
end

class ActiveSupport::Callbacks::Filters::After
end

class ActiveSupport::Callbacks::Filters::Around
  def apply(callback_sequence); end

  def initialize(user_callback, user_conditions); end
end

class ActiveSupport::Callbacks::Filters::Around
end

class ActiveSupport::Callbacks::Filters::Before
  def apply(callback_sequence); end

  def call(env); end

  def filter(); end

  def halted_lambda(); end

  def initialize(user_callback, user_conditions, chain_config, filter, name); end

  def name(); end

  def user_callback(); end

  def user_conditions(); end
end

class ActiveSupport::Callbacks::Filters::Before
end

class ActiveSupport::Callbacks::Filters::Environment
  def halted(); end

  def halted=(_); end

  def target(); end

  def target=(_); end

  def value(); end

  def value=(_); end
end

class ActiveSupport::Callbacks::Filters::Environment
  def self.[](*arg); end

  def self.keyword_init?(); end

  def self.members(); end
end

module ActiveSupport::Callbacks::Filters
end

module ActiveSupport::Callbacks
  extend ::ActiveSupport::Concern
end

module ActiveSupport::ClassAttribute
end

module ActiveSupport::ClassAttribute
  def self.redefine(owner, name, namespaced_name, value); end

  def self.redefine_method(owner, name, private: T.unsafe(nil), &block); end
end

class ActiveSupport::CodeGenerator
  def class_eval(); end

  def define_cached_method(canonical_name, namespace:, as: T.unsafe(nil), &block); end

  def execute(); end

  def initialize(owner, path, line); end
end

class ActiveSupport::CodeGenerator::MethodSet
  def apply(owner, path, line); end

  def define_cached_method(canonical_name, as: T.unsafe(nil)); end

  def initialize(namespace); end
  METHOD_CACHES = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::CodeGenerator::MethodSet
end

class ActiveSupport::CodeGenerator
  def self.batch(owner, path, line); end
end

module ActiveSupport::Concern
  def append_features(base); end

  def class_methods(&class_methods_module_definition); end

  def included(base=T.unsafe(nil), &block); end

  def prepend_features(base); end

  def prepended(base=T.unsafe(nil), &block); end
end

class ActiveSupport::Concern::MultipleIncludedBlocks
  def initialize(); end
end

class ActiveSupport::Concern::MultipleIncludedBlocks
end

class ActiveSupport::Concern::MultiplePrependBlocks
  def initialize(); end
end

class ActiveSupport::Concern::MultiplePrependBlocks
end

module ActiveSupport::Concern
  def self.extended(base); end
end

module ActiveSupport::Concurrency
end

class ActiveSupport::Concurrency::ShareLock
  include ::MonitorMixin
  def exclusive(purpose: T.unsafe(nil), compatible: T.unsafe(nil), after_compatible: T.unsafe(nil), no_wait: T.unsafe(nil)); end

  def initialize(); end

  def raw_state(); end

  def sharing(); end

  def start_exclusive(purpose: T.unsafe(nil), compatible: T.unsafe(nil), no_wait: T.unsafe(nil)); end

  def start_sharing(); end

  def stop_exclusive(compatible: T.unsafe(nil)); end

  def stop_sharing(); end

  def yield_shares(purpose: T.unsafe(nil), compatible: T.unsafe(nil), block_share: T.unsafe(nil)); end
end

class ActiveSupport::Concurrency::ShareLock
end

module ActiveSupport::Concurrency
end

module ActiveSupport::Configurable
  def config(); end
end

module ActiveSupport::Configurable::ClassMethods
  def config(); end

  def configure(); end
end

module ActiveSupport::Configurable::ClassMethods
end

class ActiveSupport::Configurable::Configuration
  def compile_methods!(); end
end

class ActiveSupport::Configurable::Configuration
  def self.compile_methods!(keys); end
end

module ActiveSupport::Configurable
  extend ::ActiveSupport::Concern
end

class ActiveSupport::ConfigurationFile
  def initialize(content_path); end

  def parse(context: T.unsafe(nil), **options); end
end

class ActiveSupport::ConfigurationFile::FormatError
end

class ActiveSupport::ConfigurationFile::FormatError
end

class ActiveSupport::ConfigurationFile
  def self.parse(content_path, **options); end
end

module ActiveSupport::CoreExt::ERBUtil
  def h(s); end

  def html_escape(s); end

  def unwrapped_html_escape(s); end
end

module ActiveSupport::CoreExt::ERBUtil
end

module ActiveSupport::CoreExt::ERBUtilPrivate
  include ::ActiveSupport::CoreExt::ERBUtil
end

module ActiveSupport::CoreExt::ERBUtilPrivate
end

class ActiveSupport::CurrentAttributes
  include ::ActiveSupport::Callbacks
  def __callbacks(); end

  def _reset_callbacks(); end

  def _run_reset_callbacks(&block); end

  def attributes(); end

  def attributes=(attributes); end

  def defaults(); end

  def defaults?(); end

  def reset(); end

  def set(attributes, &block); end
  INVALID_ATTRIBUTE_NAMES = ::T.let(nil, ::T.untyped)
  NOT_SET = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::CurrentAttributes
  extend ::ActiveSupport::Callbacks::ClassMethods
  extend ::ActiveSupport::DescendantsTracker
  def self.__callbacks(); end

  def self.__callbacks=(value); end

  def self._reset_callbacks(); end

  def self._reset_callbacks=(value); end

  def self.after_reset(*methods, &block); end

  def self.attribute(*names, default: T.unsafe(nil)); end

  def self.attributes(&arg); end

  def self.attributes=(arg); end

  def self.before_reset(*methods, &block); end

  def self.clear_all(); end

  def self.defaults(); end

  def self.defaults=(value); end

  def self.defaults?(); end

  def self.instance(); end

  def self.reset(*arg, **arg1, &arg2); end

  def self.reset_all(); end

  def self.resets(*methods, &block); end

  def self.set(*arg, **arg1, &arg2); end
end

module ActiveSupport::DeepMergeable
  def deep_merge(other, &block); end

  def deep_merge!(other, &block); end

  def deep_merge?(other); end
end

module ActiveSupport::DeepMergeable
end

module ActiveSupport::Delegation
  RESERVED_METHOD_NAMES = ::T.let(nil, ::T.untyped)
  RUBY_RESERVED_KEYWORDS = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::Delegation
  def self.generate(owner, methods, location: T.unsafe(nil), to: T.unsafe(nil), prefix: T.unsafe(nil), allow_nil: T.unsafe(nil), nilable: T.unsafe(nil), private: T.unsafe(nil), as: T.unsafe(nil), signature: T.unsafe(nil)); end

  def self.generate_method_missing(owner, target, allow_nil: T.unsafe(nil)); end
end

class ActiveSupport::DelegationError
end

class ActiveSupport::DelegationError
  def self.nil_target(method_name, target); end
end

module ActiveSupport::Dependencies
end

class ActiveSupport::Dependencies::Interlock
  def done_running(); end

  def done_unloading(); end

  def loading(&block); end

  def permit_concurrent_loads(&block); end

  def raw_state(&block); end

  def running(&block); end

  def start_running(); end

  def start_unloading(); end

  def unloading(&block); end
end

class ActiveSupport::Dependencies::Interlock
end

module ActiveSupport::Dependencies::RequireDependency
  def require_dependency(filename); end
end

module ActiveSupport::Dependencies::RequireDependency
end

module ActiveSupport::Dependencies
  def self._autoloaded_tracked_classes(); end

  def self._autoloaded_tracked_classes=(_autoloaded_tracked_classes); end

  def self._eager_load_paths(); end

  def self._eager_load_paths=(_eager_load_paths); end

  def self.autoload_once_paths(); end

  def self.autoload_once_paths=(autoload_once_paths); end

  def self.autoload_paths(); end

  def self.autoload_paths=(autoload_paths); end

  def self.autoloader(); end

  def self.autoloader=(autoloader); end

  def self.clear(); end

  def self.eager_load?(path); end

  def self.interlock(); end

  def self.interlock=(interlock); end

  def self.load_interlock(&block); end

  def self.run_interlock(&block); end

  def self.search_for_file(relpath); end

  def self.unload_interlock(&block); end
end

class ActiveSupport::Deprecation
  include ::ActiveSupport::Deprecation::Behavior
  include ::ActiveSupport::Deprecation::Reporting
  include ::ActiveSupport::Deprecation::Disallowed
  include ::ActiveSupport::Deprecation::MethodWrapper
  def deprecation_horizon(); end

  def deprecation_horizon=(deprecation_horizon); end

  def initialize(deprecation_horizon=T.unsafe(nil), gem_name=T.unsafe(nil)); end
  DEFAULT_BEHAVIORS = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::Deprecation::Behavior
  def behavior(); end

  def behavior=(behavior); end

  def debug(); end

  def debug=(debug); end

  def disallowed_behavior(); end

  def disallowed_behavior=(behavior); end
end

module ActiveSupport::Deprecation::Behavior
end

module ActiveSupport::Deprecation::DeprecatedConstantAccessor
end

module ActiveSupport::Deprecation::DeprecatedConstantAccessor
  def self.included(base); end
end

class ActiveSupport::Deprecation::DeprecatedConstantProxy
  def append_features(base); end

  def extended(base); end

  def hash(*arg, **arg1, &arg2); end

  def initialize(old_const, new_const, deprecator, message: T.unsafe(nil)); end

  def instance_methods(*arg, **arg1, &arg2); end

  def name(*arg, **arg1, &arg2); end

  def prepend_features(base); end

  def respond_to?(*arg, **arg1, &arg2); end
end

class ActiveSupport::Deprecation::DeprecatedConstantProxy
  def self.new(*args, **options, &block); end
end

class ActiveSupport::Deprecation::DeprecatedInstanceVariableProxy
  def initialize(instance, method, var=T.unsafe(nil), deprecator:); end
end

class ActiveSupport::Deprecation::DeprecatedInstanceVariableProxy
end

class ActiveSupport::Deprecation::DeprecatedObjectProxy
  def initialize(object, message, deprecator); end
end

class ActiveSupport::Deprecation::DeprecatedObjectProxy
end

class ActiveSupport::Deprecation::DeprecationProxy
end

class ActiveSupport::Deprecation::DeprecationProxy
  def self.new(*args, **kwargs, &block); end
end

class ActiveSupport::Deprecation::Deprecators
  def [](name); end

  def []=(name, deprecator); end

  def behavior=(behavior); end

  def debug=(debug); end

  def disallowed_behavior=(disallowed_behavior); end

  def disallowed_warnings=(disallowed_warnings); end

  def each(&block); end

  def silence(&block); end

  def silenced=(silenced); end
end

class ActiveSupport::Deprecation::Deprecators
end

module ActiveSupport::Deprecation::Disallowed
  def disallowed_warnings(); end

  def disallowed_warnings=(disallowed_warnings); end
end

module ActiveSupport::Deprecation::Disallowed
end

module ActiveSupport::Deprecation::MethodWrapper
  def deprecate_methods(target_module, *method_names); end
end

module ActiveSupport::Deprecation::MethodWrapper
end

module ActiveSupport::Deprecation::Reporting
  def allow(allowed_warnings=T.unsafe(nil), if: T.unsafe(nil), &block); end

  def begin_silence(); end

  def deprecation_warning(deprecated_method_name, message=T.unsafe(nil), caller_backtrace=T.unsafe(nil)); end

  def end_silence(); end

  def gem_name(); end

  def gem_name=(gem_name); end

  def silence(&block); end

  def silenced(); end

  def silenced=(silenced); end

  def warn(message=T.unsafe(nil), callstack=T.unsafe(nil)); end
  LIB_DIR = ::T.let(nil, ::T.untyped)
  RAILS_GEM_ROOT = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::Deprecation::Reporting
end

class ActiveSupport::Deprecation
  def self._instance(); end
end

module ActiveSupport::DescendantsTracker
  def descendants(); end
end

module ActiveSupport::DescendantsTracker::ReloadedClassesFiltering
  def descendants(); end

  def subclasses(); end
end

module ActiveSupport::DescendantsTracker::ReloadedClassesFiltering
end

class ActiveSupport::DescendantsTracker::WeakSet
  def <<(object); end

  def to_a(); end
end

class ActiveSupport::DescendantsTracker::WeakSet
end

module ActiveSupport::DescendantsTracker
  def self.clear(classes); end

  def self.descendants(klass); end

  def self.disable_clear!(); end

  def self.reject!(classes); end

  def self.subclasses(klass); end
end

class ActiveSupport::Digest
end

class ActiveSupport::Digest
  def self.hash_digest_class(); end

  def self.hash_digest_class=(klass); end

  def self.hexdigest(arg); end
end

class ActiveSupport::Duration
  def %(other); end

  def *(other); end

  def +(other); end

  def +@(); end

  def -(other); end

  def -@(); end

  def /(other); end

  def ==(other); end

  def _parts(); end

  def abs(&arg); end

  def after(time=T.unsafe(nil)); end

  def ago(time=T.unsafe(nil)); end

  def before(time=T.unsafe(nil)); end

  def coerce(other); end

  def encode_with(coder); end

  def eql?(other); end

  def from_now(time=T.unsafe(nil)); end

  def in_days(); end

  def in_hours(); end

  def in_minutes(); end

  def in_months(); end

  def in_seconds(); end

  def in_weeks(); end

  def in_years(); end

  def init_with(coder); end

  def initialize(value, parts, variable=T.unsafe(nil)); end

  def instance_of?(klass); end

  def is_a?(klass); end

  def iso8601(precision: T.unsafe(nil)); end

  def kind_of?(klass); end

  def negative?(&arg); end

  def parts(); end

  def positive?(&arg); end

  def since(time=T.unsafe(nil)); end

  def to_f(&arg); end

  def to_i(); end

  def until(time=T.unsafe(nil)); end

  def value(); end

  def variable?(); end

  def zero?(&arg); end
  PARTS = ::T.let(nil, ::T.untyped)
  PARTS_IN_SECONDS = ::T.let(nil, ::T.untyped)
  SECONDS_PER_DAY = ::T.let(nil, ::T.untyped)
  SECONDS_PER_HOUR = ::T.let(nil, ::T.untyped)
  SECONDS_PER_MINUTE = ::T.let(nil, ::T.untyped)
  SECONDS_PER_MONTH = ::T.let(nil, ::T.untyped)
  SECONDS_PER_WEEK = ::T.let(nil, ::T.untyped)
  SECONDS_PER_YEAR = ::T.let(nil, ::T.untyped)
  VARIABLE_PARTS = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::Duration::ISO8601Parser
  def initialize(string); end

  def mode(); end

  def mode=(mode); end

  def parse!(); end

  def parts(); end

  def scanner(); end

  def sign(); end

  def sign=(sign); end
  COMMA = ::T.let(nil, ::T.untyped)
  DATE_COMPONENT = ::T.let(nil, ::T.untyped)
  DATE_COMPONENTS = ::T.let(nil, ::T.untyped)
  DATE_MARKER = ::T.let(nil, ::T.untyped)
  DATE_TO_PART = ::T.let(nil, ::T.untyped)
  PERIOD = ::T.let(nil, ::T.untyped)
  PERIOD_OR_COMMA = ::T.let(nil, ::T.untyped)
  SIGN_MARKER = ::T.let(nil, ::T.untyped)
  TIME_COMPONENT = ::T.let(nil, ::T.untyped)
  TIME_COMPONENTS = ::T.let(nil, ::T.untyped)
  TIME_MARKER = ::T.let(nil, ::T.untyped)
  TIME_TO_PART = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::Duration::ISO8601Parser::ParsingError
end

class ActiveSupport::Duration::ISO8601Parser::ParsingError
end

class ActiveSupport::Duration::ISO8601Parser
end

class ActiveSupport::Duration::ISO8601Serializer
  def initialize(duration, precision: T.unsafe(nil)); end

  def serialize(); end
  DATE_COMPONENTS = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::Duration::ISO8601Serializer
end

class ActiveSupport::Duration::Scalar
  def %(other); end

  def *(other); end

  def +(other); end

  def -(other); end

  def /(other); end

  def coerce(other); end

  def initialize(value); end

  def to_f(*arg, **arg1, &arg2); end

  def to_i(*arg, **arg1, &arg2); end

  def to_s(*arg, **arg1, &arg2); end

  def value(); end

  def variable?(); end
end

class ActiveSupport::Duration::Scalar
end

class ActiveSupport::Duration
  def self.===(other); end

  def self.build(value); end

  def self.days(value); end

  def self.hours(value); end

  def self.minutes(value); end

  def self.months(value); end

  def self.parse(iso8601duration); end

  def self.seconds(value); end

  def self.weeks(value); end

  def self.years(value); end
end

module ActiveSupport::EnumerableCoreExt
end

module ActiveSupport::EnumerableCoreExt::Constants
end

module ActiveSupport::EnumerableCoreExt::Constants
end

class ActiveSupport::EnumerableCoreExt::SoleItemExpectedError
end

class ActiveSupport::EnumerableCoreExt::SoleItemExpectedError
end

module ActiveSupport::EnumerableCoreExt
end

class ActiveSupport::EnvironmentInquirer
  def development?(); end

  def initialize(env); end

  def local?(); end

  def production?(); end

  def test?(); end
  DEFAULT_ENVIRONMENTS = ::T.let(nil, ::T.untyped)
  LOCAL_ENVIRONMENTS = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::EnvironmentInquirer
end

class ActiveSupport::ErrorReporter
  def debug_mode(); end

  def debug_mode=(debug_mode); end

  def disable(subscriber); end

  def handle(*error_classes, severity: T.unsafe(nil), context: T.unsafe(nil), fallback: T.unsafe(nil), source: T.unsafe(nil)); end

  def initialize(*subscribers, logger: T.unsafe(nil)); end

  def logger(); end

  def logger=(logger); end

  def record(*error_classes, severity: T.unsafe(nil), context: T.unsafe(nil), source: T.unsafe(nil)); end

  def report(error, handled: T.unsafe(nil), severity: T.unsafe(nil), context: T.unsafe(nil), source: T.unsafe(nil)); end

  def set_context(*arg, **arg1, &arg2); end

  def subscribe(subscriber); end

  def unexpected(error, severity: T.unsafe(nil), context: T.unsafe(nil), source: T.unsafe(nil)); end

  def unsubscribe(subscriber); end
  DEFAULT_RESCUE = ::T.let(nil, ::T.untyped)
  DEFAULT_SOURCE = ::T.let(nil, ::T.untyped)
  SEVERITIES = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::ErrorReporter::UnexpectedError
end

class ActiveSupport::ErrorReporter::UnexpectedError
end

class ActiveSupport::ErrorReporter
end

module ActiveSupport::ExecutionContext
end

module ActiveSupport::ExecutionContext
  def self.[]=(key, value); end

  def self.after_change(&block); end

  def self.clear(); end

  def self.set(**options); end

  def self.to_h(); end
end

class ActiveSupport::ExecutionWrapper
  include ::ActiveSupport::Callbacks
  def __callbacks(); end

  def _complete_callbacks(); end

  def _run_callbacks(); end

  def _run_complete_callbacks(&block); end

  def _run_run_callbacks(&block); end

  def complete(); end

  def complete!(); end

  def run(); end

  def run!(); end
  Null = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::ExecutionWrapper::CompleteHook
  def after(target); end

  def before(target); end

  def hook(); end

  def hook=(_); end
end

class ActiveSupport::ExecutionWrapper::CompleteHook
  def self.[](*arg); end

  def self.keyword_init?(); end

  def self.members(); end
end

class ActiveSupport::ExecutionWrapper::RunHook
  def before(target); end

  def hook(); end

  def hook=(_); end
end

class ActiveSupport::ExecutionWrapper::RunHook
  def self.[](*arg); end

  def self.keyword_init?(); end

  def self.members(); end
end

class ActiveSupport::ExecutionWrapper
  extend ::ActiveSupport::Callbacks::ClassMethods
  extend ::ActiveSupport::DescendantsTracker
  def self.__callbacks(); end

  def self.__callbacks=(value); end

  def self._complete_callbacks(); end

  def self._complete_callbacks=(value); end

  def self._run_callbacks(); end

  def self._run_callbacks=(value); end

  def self.active?(); end

  def self.active_key(); end

  def self.error_reporter(); end

  def self.perform(); end

  def self.register_hook(hook, outer: T.unsafe(nil)); end

  def self.run!(reset: T.unsafe(nil)); end

  def self.to_complete(*args, &block); end

  def self.to_run(*args, &block); end

  def self.wrap(source: T.unsafe(nil)); end
end

class ActiveSupport::Executor
end

class ActiveSupport::Executor
end

class ActiveSupport::FileUpdateChecker
  def execute(); end

  def execute_if_updated(); end

  def initialize(files, dirs=T.unsafe(nil), &block); end

  def updated?(); end
end

class ActiveSupport::FileUpdateChecker
end

module ActiveSupport::ForkTracker
end

module ActiveSupport::ForkTracker::CoreExt
  def _fork(); end
end

module ActiveSupport::ForkTracker::CoreExt
end

module ActiveSupport::ForkTracker
  def self.after_fork(&block); end

  def self.after_fork_callback(); end

  def self.hook!(); end

  def self.unregister(callback); end
end

module ActiveSupport::Gzip
end

class ActiveSupport::Gzip::Stream
  def initialize(*arg); end
end

class ActiveSupport::Gzip::Stream
end

module ActiveSupport::Gzip
  def self.compress(source, level=T.unsafe(nil), strategy=T.unsafe(nil)); end

  def self.decompress(source); end
end

module ActiveSupport::Inflector
  def camelize(term, uppercase_first_letter=T.unsafe(nil)); end

  def classify(table_name); end

  def constantize(camel_cased_word); end

  def dasherize(underscored_word); end

  def deconstantize(path); end

  def demodulize(path); end

  def downcase_first(string); end

  def foreign_key(class_name, separate_class_name_and_id_with_underscore=T.unsafe(nil)); end

  def humanize(lower_case_and_underscored_word, capitalize: T.unsafe(nil), keep_id_suffix: T.unsafe(nil)); end

  def inflections(locale=T.unsafe(nil)); end

  def ordinal(number); end

  def ordinalize(number); end

  def parameterize(string, separator: T.unsafe(nil), preserve_case: T.unsafe(nil), locale: T.unsafe(nil)); end

  def pluralize(word, locale=T.unsafe(nil)); end

  def safe_constantize(camel_cased_word); end

  def singularize(word, locale=T.unsafe(nil)); end

  def tableize(class_name); end

  def titleize(word, keep_id_suffix: T.unsafe(nil)); end

  def transliterate(string, replacement=T.unsafe(nil), locale: T.unsafe(nil)); end

  def underscore(camel_cased_word); end

  def upcase_first(string); end
  ALLOWED_ENCODINGS_FOR_TRANSLITERATE = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::Inflector::Inflections
  def acronym(word); end

  def acronyms(); end

  def acronyms_camelize_regex(); end

  def acronyms_underscore_regex(); end

  def clear(scope=T.unsafe(nil)); end

  def human(rule, replacement); end

  def humans(); end

  def irregular(singular, plural); end

  def plural(rule, replacement); end

  def plurals(); end

  def singular(rule, replacement); end

  def singulars(); end

  def uncountable(*words); end

  def uncountables(); end
end

class ActiveSupport::Inflector::Inflections::Uncountables
  def <<(*word); end

  def add(words); end

  def delete(entry); end

  def initialize(); end

  def uncountable?(str); end
end

class ActiveSupport::Inflector::Inflections::Uncountables
end

class ActiveSupport::Inflector::Inflections
  def self.instance(locale=T.unsafe(nil)); end

  def self.instance_or_fallback(locale); end
end

module ActiveSupport::Inflector
  extend ::ActiveSupport::Inflector
end

class ActiveSupport::InheritableOptions
  def ==(other); end

  def each(&block); end

  def inheritable_copy(); end

  def initialize(parent=T.unsafe(nil)); end

  def key?(key); end

  def overridden?(key); end

  def pretty_print(pp); end
end

class ActiveSupport::InheritableOptions
end

module ActiveSupport::IsolatedExecutionState
end

module ActiveSupport::IsolatedExecutionState
  def self.[](key); end

  def self.[]=(key, value); end

  def self.clear(); end

  def self.context(); end

  def self.delete(key); end

  def self.isolation_level(); end

  def self.isolation_level=(level); end

  def self.key?(key); end

  def self.scope(); end

  def self.share_with(other); end

  def self.unique_id(); end
end

module ActiveSupport::JSON
  DATETIME_REGEX = ::T.let(nil, ::T.untyped)
  DATE_REGEX = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::JSON::Encoding
end

class ActiveSupport::JSON::Encoding::JSONGemEncoder
  def encode(value); end

  def initialize(options=T.unsafe(nil)); end

  def options(); end
end

class ActiveSupport::JSON::Encoding::JSONGemEncoder
end

module ActiveSupport::JSON::Encoding
  def self.escape_html_entities_in_json(); end

  def self.escape_html_entities_in_json=(escape_html_entities_in_json); end

  def self.json_encoder(); end

  def self.json_encoder=(json_encoder); end

  def self.time_precision(); end

  def self.time_precision=(time_precision); end

  def self.use_standard_json_time_format(); end

  def self.use_standard_json_time_format=(use_standard_json_time_format); end
end

module ActiveSupport::JSON
  def self.decode(json); end

  def self.dump(value, options=T.unsafe(nil)); end

  def self.encode(value, options=T.unsafe(nil)); end

  def self.load(json); end

  def self.parse_error(); end
end

class ActiveSupport::KeyGenerator
  def generate_key(salt, key_size=T.unsafe(nil)); end

  def initialize(secret, options=T.unsafe(nil)); end
end

class ActiveSupport::KeyGenerator
  def self.hash_digest_class(); end

  def self.hash_digest_class=(klass); end
end

module ActiveSupport::LazyLoadHooks
  def on_load(name, options=T.unsafe(nil), &block); end

  def run_load_hooks(name, base=T.unsafe(nil)); end
end

module ActiveSupport::LazyLoadHooks
  def self.extended(base); end
end

class ActiveSupport::LogSubscriber
  def colorize_logging(); end

  def colorize_logging=(val); end

  def debug(progname=T.unsafe(nil), &block); end

  def error(progname=T.unsafe(nil), &block); end

  def event_levels=(event_levels); end

  def fatal(progname=T.unsafe(nil), &block); end

  def info(progname=T.unsafe(nil), &block); end

  def logger(); end

  def silenced?(event); end

  def unknown(progname=T.unsafe(nil), &block); end

  def warn(progname=T.unsafe(nil), &block); end
  BLACK = ::T.let(nil, ::T.untyped)
  BLUE = ::T.let(nil, ::T.untyped)
  CYAN = ::T.let(nil, ::T.untyped)
  GREEN = ::T.let(nil, ::T.untyped)
  LEVEL_CHECKS = ::T.let(nil, ::T.untyped)
  MAGENTA = ::T.let(nil, ::T.untyped)
  MODES = ::T.let(nil, ::T.untyped)
  RED = ::T.let(nil, ::T.untyped)
  WHITE = ::T.let(nil, ::T.untyped)
  YELLOW = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::LogSubscriber
  def self.attach_to(*arg, **arg1, &arg2); end

  def self.colorize_logging(); end

  def self.colorize_logging=(val); end

  def self.flush_all!(); end

  def self.log_levels(); end

  def self.log_levels=(value); end

  def self.log_levels?(); end

  def self.log_subscribers(); end

  def self.logger(); end

  def self.logger=(logger); end
end

class ActiveSupport::Logger
  include ::ActiveSupport::LoggerSilence
  include ::ActiveSupport::LoggerThreadSafeLevel
  def initialize(*args, **kwargs); end

  def silencer(); end

  def silencer=(val); end
end

class ActiveSupport::Logger::SimpleFormatter
  def call(severity, timestamp, progname, msg); end
end

class ActiveSupport::Logger::SimpleFormatter
end

class ActiveSupport::Logger
  def self.logger_outputs_to?(logger, *sources); end

  def self.normalize_sources(sources); end

  def self.silencer(); end

  def self.silencer=(val); end
end

module ActiveSupport::LoggerSilence
  def silence(severity=T.unsafe(nil)); end
end

module ActiveSupport::LoggerSilence
  extend ::ActiveSupport::Concern
end

module ActiveSupport::LoggerThreadSafeLevel
  def level(); end

  def local_level(); end

  def local_level=(level); end

  def log_at(level); end
end

module ActiveSupport::LoggerThreadSafeLevel
  extend ::ActiveSupport::Concern
end

class ActiveSupport::MessageEncryptor
  include ::ActiveSupport::Messages::Rotator
  def create_message(value, **options); end

  def decrypt_and_verify(message, **options); end

  def encrypt_and_sign(value, **options); end
  AUTH_TAG_LENGTH = ::T.let(nil, ::T.untyped)
  SEPARATOR = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::MessageEncryptor::InvalidMessage
end

class ActiveSupport::MessageEncryptor::InvalidMessage
end

module ActiveSupport::MessageEncryptor::NullSerializer
end

module ActiveSupport::MessageEncryptor::NullSerializer
  def self.dump(value); end

  def self.load(value); end
end

ActiveSupport::MessageEncryptor::OpenSSLCipherError = OpenSSL::Cipher::CipherError

class ActiveSupport::MessageEncryptor
  def self.default_cipher(); end

  def self.key_len(cipher=T.unsafe(nil)); end

  def self.use_authenticated_message_encryption(); end

  def self.use_authenticated_message_encryption=(val); end
end

class ActiveSupport::MessageEncryptors
end

class ActiveSupport::MessageEncryptors
end

class ActiveSupport::MessageVerifier
  include ::ActiveSupport::Messages::Rotator
  def create_message(value, **options); end

  def generate(value, **options); end

  def valid_message?(message); end

  def verified(message, **options); end

  def verify(message, **options); end
  SEPARATOR = ::T.let(nil, ::T.untyped)
  SEPARATOR_LENGTH = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::MessageVerifier::InvalidSignature
end

class ActiveSupport::MessageVerifier::InvalidSignature
end

class ActiveSupport::MessageVerifier
end

class ActiveSupport::MessageVerifiers
end

class ActiveSupport::MessageVerifiers
end

class ActiveSupport::Messages::Codec
  include ::ActiveSupport::Messages::Metadata
  def initialize(**options); end
end

class ActiveSupport::Messages::Codec
  def self.default_serializer(); end

  def self.default_serializer=(value); end
end

module ActiveSupport::Messages::Metadata
  ENVELOPE_SERIALIZERS = ::T.let(nil, ::T.untyped)
  TIMESTAMP_SERIALIZERS = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::Messages::Metadata
  def self.use_message_serializer_for_metadata(); end

  def self.use_message_serializer_for_metadata=(use_message_serializer_for_metadata); end
end

class ActiveSupport::Messages::RotationCoordinator
  def [](salt); end

  def []=(salt, codec); end

  def clear_rotations(); end

  def initialize(&secret_generator); end

  def on_rotation(&callback); end

  def rotate(**options, &block); end

  def rotate_defaults(); end

  def transitional(); end

  def transitional=(transitional); end
end

class ActiveSupport::Messages::RotationCoordinator
end

module ActiveSupport::Messages::Rotator
  def fall_back_to(fallback); end

  def initialize(*args, on_rotation: T.unsafe(nil), **options); end

  def on_rotation(&on_rotation); end

  def read_message(message, on_rotation: T.unsafe(nil), **options); end

  def rotate(*args, **options); end
end

module ActiveSupport::Messages::Rotator
end

module ActiveSupport::Multibyte
end

class ActiveSupport::Multibyte::Chars
  include ::Comparable
  def =~(*arg, **arg1, &arg2); end

  def acts_like_string?(*arg, **arg1, &arg2); end

  def compose(); end

  def decompose(); end

  def grapheme_length(); end

  def initialize(string); end

  def limit(limit); end

  def match?(*arg, **arg1, &arg2); end

  def method_missing(method, *arg, **arg1, &arg2); end

  def reverse(); end

  def reverse!(*args); end

  def slice!(*args); end

  def split(*args); end

  def tidy_bytes(force=T.unsafe(nil)); end

  def tidy_bytes!(*args); end

  def titlecase(); end

  def titleize(); end

  def to_str(); end

  def wrapped_string(); end
end

class ActiveSupport::Multibyte::Chars
end

module ActiveSupport::Multibyte::Unicode
  def compose(codepoints); end

  def decompose(type, codepoints); end

  def tidy_bytes(string, force=T.unsafe(nil)); end
  UNICODE_VERSION = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::Multibyte::Unicode
  extend ::ActiveSupport::Multibyte::Unicode
end

module ActiveSupport::Multibyte
  def self.proxy_class(); end

  def self.proxy_class=(klass); end
end

module ActiveSupport::Notifications
end

class ActiveSupport::Notifications::Event
  def allocations(); end

  def cpu_time(); end

  def duration(); end

  def end(); end

  def finish!(); end

  def gc_time(); end

  def idle_time(); end

  def initialize(name, start, ending, transaction_id, payload); end

  def name(); end

  def payload(); end

  def payload=(payload); end

  def record(); end

  def start!(); end

  def time(); end

  def transaction_id(); end
end

class ActiveSupport::Notifications::Event
end

class ActiveSupport::Notifications::Fanout
  include ::ActiveSupport::Notifications::FanoutIteration
  def all_listeners_for(name); end

  def build_handle(name, id, payload); end

  def clear_cache(key=T.unsafe(nil)); end

  def finish(name, id, payload, listeners=T.unsafe(nil)); end

  def groups_for(name); end

  def listeners_for(name); end

  def listening?(name); end

  def publish(name, *args); end

  def publish_event(event); end

  def start(name, id, payload); end

  def subscribe(pattern=T.unsafe(nil), callable=T.unsafe(nil), monotonic: T.unsafe(nil), &block); end

  def unsubscribe(subscriber_or_name); end

  def wait(); end
end

class ActiveSupport::Notifications::Fanout::BaseGroup
  include ::ActiveSupport::Notifications::FanoutIteration
  def each(&block); end

  def initialize(listeners, name, id, payload); end
end

class ActiveSupport::Notifications::Fanout::BaseGroup
end

class ActiveSupport::Notifications::Fanout::BaseTimeGroup
  def finish(name, id, payload); end

  def start(name, id, payload); end
end

class ActiveSupport::Notifications::Fanout::BaseTimeGroup
end

class ActiveSupport::Notifications::Fanout::EventObjectGroup
  def finish(name, id, payload); end

  def start(name, id, payload); end
end

class ActiveSupport::Notifications::Fanout::EventObjectGroup
end

class ActiveSupport::Notifications::Fanout::EventedGroup
  def finish(name, id, payload); end

  def start(name, id, payload); end
end

class ActiveSupport::Notifications::Fanout::EventedGroup
end

class ActiveSupport::Notifications::Fanout::Handle
  include ::ActiveSupport::Notifications::FanoutIteration
  def finish(); end

  def finish_with_values(name, id, payload); end

  def initialize(notifier, name, id, payload); end

  def start(); end
end

class ActiveSupport::Notifications::Fanout::Handle
end

class ActiveSupport::Notifications::Fanout::MonotonicTimedGroup
end

class ActiveSupport::Notifications::Fanout::MonotonicTimedGroup
end

module ActiveSupport::Notifications::Fanout::Subscribers
end

class ActiveSupport::Notifications::Fanout::Subscribers::EventObject
end

class ActiveSupport::Notifications::Fanout::Subscribers::EventObject
end

class ActiveSupport::Notifications::Fanout::Subscribers::Evented
  def delegate(); end

  def group_class(); end

  def initialize(pattern, delegate); end

  def pattern(); end

  def publish(name, *args); end

  def publish_event(event); end

  def silenceable(); end

  def silenced?(name); end

  def subscribed_to?(name); end

  def unsubscribe!(name); end
end

class ActiveSupport::Notifications::Fanout::Subscribers::Evented
end

class ActiveSupport::Notifications::Fanout::Subscribers::Matcher
  def ===(name); end

  def exclusions(); end

  def initialize(pattern); end

  def pattern(); end

  def unsubscribe!(name); end
end

class ActiveSupport::Notifications::Fanout::Subscribers::Matcher::AllMessages
  def ===(name); end

  def unsubscribe!(*arg); end
end

class ActiveSupport::Notifications::Fanout::Subscribers::Matcher::AllMessages
end

class ActiveSupport::Notifications::Fanout::Subscribers::Matcher
  def self.wrap(pattern); end
end

class ActiveSupport::Notifications::Fanout::Subscribers::MonotonicTimed
end

class ActiveSupport::Notifications::Fanout::Subscribers::MonotonicTimed
end

class ActiveSupport::Notifications::Fanout::Subscribers::Timed
end

class ActiveSupport::Notifications::Fanout::Subscribers::Timed
end

module ActiveSupport::Notifications::Fanout::Subscribers
  def self.new(pattern, listener, monotonic); end
end

class ActiveSupport::Notifications::Fanout::TimedGroup
end

class ActiveSupport::Notifications::Fanout::TimedGroup
end

class ActiveSupport::Notifications::Fanout
end

module ActiveSupport::Notifications::FanoutIteration
end

module ActiveSupport::Notifications::FanoutIteration
end

class ActiveSupport::Notifications::InstrumentationSubscriberError
  def exceptions(); end

  def initialize(exceptions); end
end

class ActiveSupport::Notifications::InstrumentationSubscriberError
end

class ActiveSupport::Notifications::Instrumenter
  def build_handle(name, payload); end

  def finish(name, payload); end

  def finish_with_state(listeners_state, name, payload); end

  def id(); end

  def initialize(notifier); end

  def instrument(name, payload=T.unsafe(nil)); end

  def new_event(name, payload=T.unsafe(nil)); end

  def start(name, payload); end
end

class ActiveSupport::Notifications::Instrumenter::LegacyHandle
  def finish(); end

  def initialize(notifier, name, id, payload); end

  def start(); end
end

class ActiveSupport::Notifications::Instrumenter::LegacyHandle::Wrapper
  def build_handle(name, id, payload); end

  def finish(*arg, **arg1, &arg2); end

  def initialize(notifier); end

  def start(*arg, **arg1, &arg2); end
end

class ActiveSupport::Notifications::Instrumenter::LegacyHandle::Wrapper
end

class ActiveSupport::Notifications::Instrumenter::LegacyHandle
end

class ActiveSupport::Notifications::Instrumenter
end

module ActiveSupport::Notifications
  def self.instrument(name, payload=T.unsafe(nil)); end

  def self.instrumenter(); end

  def self.monotonic_subscribe(pattern=T.unsafe(nil), callback=T.unsafe(nil), &block); end

  def self.notifier(); end

  def self.notifier=(notifier); end

  def self.publish(name, *args); end

  def self.publish_event(event); end

  def self.subscribe(pattern=T.unsafe(nil), callback=T.unsafe(nil), &block); end

  def self.subscribed(callback, pattern=T.unsafe(nil), monotonic: T.unsafe(nil), &block); end

  def self.unsubscribe(subscriber_or_name); end
end

module ActiveSupport::NumberHelper
  def number_to_currency(number, options=T.unsafe(nil)); end

  def number_to_delimited(number, options=T.unsafe(nil)); end

  def number_to_human(number, options=T.unsafe(nil)); end

  def number_to_human_size(number, options=T.unsafe(nil)); end

  def number_to_percentage(number, options=T.unsafe(nil)); end

  def number_to_phone(number, options=T.unsafe(nil)); end

  def number_to_rounded(number, options=T.unsafe(nil)); end
end

class ActiveSupport::NumberHelper::NumberConverter
  def execute(); end

  def initialize(number, options); end

  def namespace(); end

  def namespace=(namespace); end

  def namespace?(); end

  def number(); end

  def opts(); end

  def validate_float(); end

  def validate_float=(validate_float); end

  def validate_float?(); end
  DEFAULTS = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::NumberHelper::NumberConverter
  def self.convert(number, options); end

  def self.namespace(); end

  def self.namespace=(value); end

  def self.namespace?(); end

  def self.validate_float(); end

  def self.validate_float=(value); end

  def self.validate_float?(); end
end

class ActiveSupport::NumberHelper::NumberToCurrencyConverter
  def convert(); end
end

class ActiveSupport::NumberHelper::NumberToCurrencyConverter
end

class ActiveSupport::NumberHelper::NumberToDelimitedConverter
  def convert(); end
  DEFAULT_DELIMITER_REGEX = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::NumberHelper::NumberToDelimitedConverter
end

class ActiveSupport::NumberHelper::NumberToHumanConverter
  def convert(); end
  DECIMAL_UNITS = ::T.let(nil, ::T.untyped)
  INVERTED_DECIMAL_UNITS = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::NumberHelper::NumberToHumanConverter
end

class ActiveSupport::NumberHelper::NumberToHumanSizeConverter
  def convert(); end
  STORAGE_UNITS = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::NumberHelper::NumberToHumanSizeConverter
end

class ActiveSupport::NumberHelper::NumberToPercentageConverter
  def convert(); end
end

class ActiveSupport::NumberHelper::NumberToPercentageConverter
end

class ActiveSupport::NumberHelper::NumberToPhoneConverter
  def convert(); end
end

class ActiveSupport::NumberHelper::NumberToPhoneConverter
end

class ActiveSupport::NumberHelper::NumberToRoundedConverter
  def convert(); end
end

class ActiveSupport::NumberHelper::NumberToRoundedConverter
end

class ActiveSupport::NumberHelper::RoundingHelper
  def digit_count(number); end

  def initialize(options); end

  def options(); end

  def round(number); end
end

class ActiveSupport::NumberHelper::RoundingHelper
end

module ActiveSupport::NumberHelper
  extend ::ActiveSupport::Autoload
  extend ::ActiveSupport::NumberHelper
end

class ActiveSupport::OptionMerger
  def initialize(context, options); end
end

class ActiveSupport::OptionMerger
end

class ActiveSupport::OrderedHash
  def encode_with(coder); end

  def nested_under_indifferent_access(); end

  def reject(*args, &block); end

  def select(*args, &block); end

  def to_yaml_type(); end
end

class ActiveSupport::OrderedHash
end

class ActiveSupport::OrderedOptions
  def [](key); end

  def []=(key, value); end

  def _get(arg); end

  def dig(key, *identifiers); end

  def method_missing(method, *args); end
end

class ActiveSupport::OrderedOptions
end

class ActiveSupport::Reloader
  def _class_unload_callbacks(); end

  def _prepare_callbacks(); end

  def _run_class_unload_callbacks(&block); end

  def _run_prepare_callbacks(&block); end

  def check(); end

  def check=(check); end

  def check?(); end

  def class_unload!(&block); end

  def executor(); end

  def executor=(executor); end

  def executor?(); end

  def release_unload_lock!(); end

  def require_unload_lock!(); end
end

class ActiveSupport::Reloader
  def self._class_unload_callbacks(); end

  def self._class_unload_callbacks=(value); end

  def self._prepare_callbacks(); end

  def self._prepare_callbacks=(value); end

  def self.after_class_unload(*args, &block); end

  def self.before_class_unload(*args, &block); end

  def self.check(); end

  def self.check!(); end

  def self.check=(value); end

  def self.check?(); end

  def self.executor(); end

  def self.executor=(value); end

  def self.executor?(); end

  def self.prepare!(); end

  def self.reload!(); end

  def self.reloaded!(); end

  def self.to_prepare(*args, &block); end

  def self.wrap(**kwargs); end
end

module ActiveSupport::Rescuable
  def handler_for_rescue(exception); end

  def rescue_with_handler(exception); end
end

module ActiveSupport::Rescuable::ClassMethods
  def handler_for_rescue(exception, object: T.unsafe(nil)); end

  def rescue_from(*klasses, with: T.unsafe(nil), &block); end

  def rescue_with_handler(exception, object: T.unsafe(nil), visited_exceptions: T.unsafe(nil)); end
end

module ActiveSupport::Rescuable::ClassMethods
end

module ActiveSupport::Rescuable
  extend ::ActiveSupport::Concern
end

class ActiveSupport::SafeBuffer
  def %(args); end

  def *(_); end

  def +(other); end

  def <<(value); end

  def [](*args); end

  def []=(arg1, arg2, arg3=T.unsafe(nil)); end

  def bytesplice(*args, value); end

  def capitalize(*args, &block); end

  def capitalize!(*args); end

  def chomp(*args, &block); end

  def chomp!(*args); end

  def chop(*args, &block); end

  def chop!(*args); end

  def concat(value); end

  def delete(*args, &block); end

  def delete!(*args); end

  def delete_prefix(*args, &block); end

  def delete_prefix!(*args); end

  def delete_suffix(*args, &block); end

  def delete_suffix!(*args); end

  def downcase(*args, &block); end

  def downcase!(*args); end

  def encode_with(coder); end

  def gsub(*args, &block); end

  def gsub!(*args, &block); end

  def initialize(str=T.unsafe(nil)); end

  def insert(index, value); end

  def lstrip(*args, &block); end

  def lstrip!(*args); end

  def next(*args, &block); end

  def next!(*args); end

  def prepend(value); end

  def replace(value); end

  def reverse(*args, &block); end

  def reverse!(*args); end

  def rstrip(*args, &block); end

  def rstrip!(*args); end

  def safe_concat(value); end

  def scrub(*args, &block); end

  def scrub!(*args); end

  def slice(*args); end

  def slice!(*args); end

  def squeeze(*args, &block); end

  def squeeze!(*args); end

  def strip(*args, &block); end

  def strip!(*args); end

  def sub(*args, &block); end

  def sub!(*args, &block); end

  def succ(*args, &block); end

  def succ!(*args); end

  def swapcase(*args, &block); end

  def swapcase!(*args); end

  def tr(*args, &block); end

  def tr!(*args); end

  def tr_s(*args, &block); end

  def tr_s!(*args); end

  def unicode_normalize(*args, &block); end

  def unicode_normalize!(*args); end

  def upcase(*args, &block); end

  def upcase!(*args); end
  UNSAFE_STRING_METHODS = ::T.let(nil, ::T.untyped)
  UNSAFE_STRING_METHODS_WITH_BACKREF = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::SafeBuffer::SafeConcatError
  def initialize(); end
end

class ActiveSupport::SafeBuffer::SafeConcatError
end

class ActiveSupport::SafeBuffer
end

class ActiveSupport::SecureCompareRotator
  include ::ActiveSupport::SecurityUtils
  def initialize(value, on_rotation: T.unsafe(nil)); end

  def rotate(previous_value); end

  def secure_compare!(other_value, on_rotation: T.unsafe(nil)); end
end

class ActiveSupport::SecureCompareRotator::InvalidMatch
end

class ActiveSupport::SecureCompareRotator::InvalidMatch
end

class ActiveSupport::SecureCompareRotator
end

module ActiveSupport::SecurityUtils
end

module ActiveSupport::SecurityUtils
  def self.fixed_length_secure_compare(a, b); end

  def self.secure_compare(a, b); end
end

class ActiveSupport::StringInquirer
end

class ActiveSupport::StringInquirer
end

class ActiveSupport::Subscriber
  def call(event); end

  def patterns(); end

  def publish_event(event); end
end

class ActiveSupport::Subscriber
  def self.attach_to(namespace, subscriber=T.unsafe(nil), notifier=T.unsafe(nil), inherit_all: T.unsafe(nil)); end

  def self.detach_from(namespace, notifier=T.unsafe(nil)); end

  def self.method_added(event); end

  def self.subscribers(); end
end

module ActiveSupport::TaggedLogging
  def clear_tags!(*arg, **arg1, &arg2); end

  def flush(); end

  def pop_tags(*arg, **arg1, &arg2); end

  def push_tags(*arg, **arg1, &arg2); end

  def tagged(*tags); end
end

module ActiveSupport::TaggedLogging::Formatter
  def call(severity, timestamp, progname, msg); end

  def clear_tags!(); end

  def current_tags(); end

  def pop_tags(count=T.unsafe(nil)); end

  def push_tags(*tags); end

  def tag_stack(); end

  def tagged(*tags); end

  def tags_text(); end
end

module ActiveSupport::TaggedLogging::Formatter
end

module ActiveSupport::TaggedLogging::LocalTagStorage
  def tag_stack(); end

  def tag_stack=(tag_stack); end
end

module ActiveSupport::TaggedLogging::LocalTagStorage
  def self.extended(base); end
end

class ActiveSupport::TaggedLogging::TagStack
  def clear(); end

  def format_message(message); end

  def pop_tags(count); end

  def push_tags(tags); end

  def tags(); end
end

class ActiveSupport::TaggedLogging::TagStack
end

module ActiveSupport::TaggedLogging
  def self.logger(*args, **kwargs); end

  def self.new(logger); end
end

class ActiveSupport::TestCase
  include ::ActiveSupport::Testing::TaggedLogging
  include ::ActiveSupport::Callbacks
  include ::ActiveSupport::Testing::Assertions
  include ::ActiveSupport::Testing::ErrorReporterAssertions
  include ::ActiveSupport::Testing::Deprecation
  include ::ActiveSupport::Testing::ConstantStubbing
  include ::ActiveSupport::Testing::TimeHelpers
  include ::ActiveSupport::Testing::FileFixtures
  include ::ActiveSupport::Testing::SetupAndTeardown
  include ::ActiveSupport::Testing::TestsWithoutAssertions
  def __callbacks(); end

  def _run_setup_callbacks(&block); end

  def _run_teardown_callbacks(&block); end

  def _setup_callbacks(); end

  def _teardown_callbacks(); end

  def assert_no_match(matcher, obj, msg=T.unsafe(nil)); end

  def assert_not_empty(obj, msg=T.unsafe(nil)); end

  def assert_not_equal(exp, act, msg=T.unsafe(nil)); end

  def assert_not_in_delta(exp, act, delta=T.unsafe(nil), msg=T.unsafe(nil)); end

  def assert_not_in_epsilon(a, b, epsilon=T.unsafe(nil), msg=T.unsafe(nil)); end

  def assert_not_includes(collection, obj, msg=T.unsafe(nil)); end

  def assert_not_instance_of(cls, obj, msg=T.unsafe(nil)); end

  def assert_not_kind_of(cls, obj, msg=T.unsafe(nil)); end

  def assert_not_nil(obj, msg=T.unsafe(nil)); end

  def assert_not_operator(o1, op, o2=T.unsafe(nil), msg=T.unsafe(nil)); end

  def assert_not_predicate(o1, op, msg=T.unsafe(nil)); end

  def assert_not_respond_to(obj, meth, msg=T.unsafe(nil), include_all: T.unsafe(nil)); end

  def assert_not_same(exp, act, msg=T.unsafe(nil)); end

  def file_fixture_path(); end

  def file_fixture_path?(); end

  def method_name(); end
end

ActiveSupport::TestCase::Assertion = Minitest::Assertion

class ActiveSupport::TestCase
  extend ::ActiveSupport::Callbacks::ClassMethods
  extend ::ActiveSupport::DescendantsTracker
  def self.__callbacks(); end

  def self.__callbacks=(value); end

  def self._setup_callbacks(); end

  def self._setup_callbacks=(value); end

  def self._teardown_callbacks(); end

  def self._teardown_callbacks=(value); end

  def self.file_fixture_path(); end

  def self.file_fixture_path=(value); end

  def self.file_fixture_path?(); end

  def self.parallelize(workers: T.unsafe(nil), with: T.unsafe(nil), threshold: T.unsafe(nil)); end

  def self.parallelize_setup(&block); end

  def self.parallelize_teardown(&block); end

  def self.test_order=(new_order); end
end

module ActiveSupport::Testing::Assertions
  def assert_changes(expression, message=T.unsafe(nil), from: T.unsafe(nil), to: T.unsafe(nil), &block); end

  def assert_difference(expression, *args, &block); end

  def assert_no_changes(expression, message=T.unsafe(nil), from: T.unsafe(nil), &block); end

  def assert_no_difference(expression, message=T.unsafe(nil), &block); end

  def assert_not(object, message=T.unsafe(nil)); end

  def assert_nothing_raised(); end

  def assert_raise(*exp, match: T.unsafe(nil), &block); end

  def assert_raises(*exp, match: T.unsafe(nil), &block); end
  UNTRACKED = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::Testing::Assertions
end

module ActiveSupport::Testing::ConstantStubbing
  def stub_const(mod, constant, new_value, exists: T.unsafe(nil)); end
end

module ActiveSupport::Testing::ConstantStubbing
end

module ActiveSupport::Testing::Deprecation
  def assert_deprecated(match=T.unsafe(nil), deprecator=T.unsafe(nil), &block); end

  def assert_not_deprecated(deprecator, &block); end

  def collect_deprecations(deprecator); end
end

module ActiveSupport::Testing::Deprecation
end

module ActiveSupport::Testing::ErrorReporterAssertions
  def assert_error_reported(error_class=T.unsafe(nil), &block); end

  def assert_no_error_reported(&block); end
end

module ActiveSupport::Testing::ErrorReporterAssertions
end

module ActiveSupport::Testing::FileFixtures
  def file_fixture(fixture_name); end
end

module ActiveSupport::Testing::FileFixtures
  extend ::ActiveSupport::Concern
end

module ActiveSupport::Testing::SetupAndTeardown
  def after_teardown(); end

  def before_setup(); end
end

module ActiveSupport::Testing::SetupAndTeardown
  def self.prepended(klass); end
end

module ActiveSupport::Testing::TaggedLogging
  def before_setup(); end

  def tagged_logger=(tagged_logger); end
end

module ActiveSupport::Testing::TaggedLogging
end

module ActiveSupport::Testing::TestsWithoutAssertions
  def after_teardown(); end
end

module ActiveSupport::Testing::TestsWithoutAssertions
end

module ActiveSupport::Testing::TimeHelpers
  def after_teardown(); end

  def freeze_time(with_usec: T.unsafe(nil), &block); end

  def travel(duration, with_usec: T.unsafe(nil), &block); end

  def travel_back(); end

  def travel_to(date_or_time, with_usec: T.unsafe(nil)); end

  def unfreeze_time(); end
end

module ActiveSupport::Testing::TimeHelpers
end

class ActiveSupport::TimeWithZone
  include ::DateAndTime::Compatibility
  include ::Comparable
  def +(other); end

  def -(other); end

  def acts_like_time?(); end

  def advance(options); end

  def after?(arg); end

  def ago(other); end

  def before?(arg); end

  def between?(min, max); end

  def change(options); end

  def comparable_time(); end

  def day(); end

  def dst?(); end

  def encode_with(coder); end

  def eql?(other); end

  def formatted_offset(colon=T.unsafe(nil), alternate_utc_string=T.unsafe(nil)); end

  def future?(); end

  def getgm(); end

  def getlocal(utc_offset=T.unsafe(nil)); end

  def getutc(); end

  def gmt?(); end

  def gmt_offset(); end

  def gmtime(); end

  def gmtoff(); end

  def hour(); end

  def httpdate(); end

  def in(other); end

  def in_time_zone(new_zone=T.unsafe(nil)); end

  def init_with(coder); end

  def initialize(utc_time, time_zone, local_time=T.unsafe(nil), period=T.unsafe(nil)); end

  def is_a?(klass); end

  def isdst(); end

  def iso8601(fraction_digits=T.unsafe(nil)); end

  def kind_of?(klass); end

  def localtime(utc_offset=T.unsafe(nil)); end

  def marshal_dump(); end

  def marshal_load(variables); end

  def mday(); end

  def method_missing(*arg, **arg1, &arg2); end

  def min(); end

  def mon(); end

  def month(); end

  def next_day?(); end

  def nsec(); end

  def past?(); end

  def period(); end

  def prev_day?(); end

  def respond_to?(sym, include_priv=T.unsafe(nil)); end

  def rfc2822(); end

  def rfc3339(fraction_digits=T.unsafe(nil)); end

  def rfc822(); end

  def sec(); end

  def since(other); end

  def strftime(format); end

  def time(); end

  def time_zone(); end

  def to_a(); end

  def to_date(); end

  def to_datetime(); end

  def to_f(); end

  def to_formatted_s(format=T.unsafe(nil)); end

  def to_fs(format=T.unsafe(nil)); end

  def to_i(); end

  def to_r(); end

  def to_time(); end

  def today?(); end

  def tomorrow?(); end

  def tv_sec(); end

  def usec(); end

  def utc(); end

  def utc?(); end

  def utc_offset(); end

  def wday(); end

  def xmlschema(fraction_digits=T.unsafe(nil)); end

  def yday(); end

  def year(); end

  def yesterday?(); end

  def zone(); end
  PRECISIONS = ::T.let(nil, ::T.untyped)
  SECONDS_PER_DAY = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::TimeWithZone
end

class ActiveSupport::TimeZone
  include ::Comparable
  def =~(re); end

  def abbr(time); end

  def at(*args); end

  def dst?(time); end

  def encode_with(coder); end

  def formatted_offset(colon=T.unsafe(nil), alternate_utc_string=T.unsafe(nil)); end

  def init_with(coder); end

  def initialize(name, utc_offset=T.unsafe(nil), tzinfo=T.unsafe(nil)); end

  def iso8601(str); end

  def local(*args); end

  def local_to_utc(time, dst=T.unsafe(nil)); end

  def match?(re); end

  def name(); end

  def now(); end

  def parse(str, now=T.unsafe(nil)); end

  def period_for_local(time, dst=T.unsafe(nil)); end

  def period_for_utc(time); end

  def periods_for_local(time); end

  def rfc3339(str); end

  def strptime(str, format, now=T.unsafe(nil)); end

  def today(); end

  def tomorrow(); end

  def tzinfo(); end

  def utc_offset(); end

  def utc_to_local(time); end

  def yesterday(); end
  MAPPING = ::T.let(nil, ::T.untyped)
end

class ActiveSupport::TimeZone
  def self.[](arg); end

  def self.all(); end

  def self.clear(); end

  def self.country_zones(country_code); end

  def self.create(*arg, **arg1); end

  def self.find_tzinfo(name); end

  def self.new(name); end

  def self.seconds_to_utc_offset(seconds, colon=T.unsafe(nil)); end

  def self.us_zones(); end
end

module ActiveSupport::ToJsonWithActiveSupportEncoder
  def to_json(options=T.unsafe(nil)); end
end

module ActiveSupport::ToJsonWithActiveSupportEncoder
end

module ActiveSupport::Tryable
  def try(*args, **arg, &block); end

  def try!(*args, **arg, &block); end
end

module ActiveSupport::Tryable
end

module ActiveSupport::VERSION
  MAJOR = ::T.let(nil, ::T.untyped)
  MINOR = ::T.let(nil, ::T.untyped)
  PRE = ::T.let(nil, ::T.untyped)
  STRING = ::T.let(nil, ::T.untyped)
  TINY = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::VERSION
end

module ActiveSupport::XmlMini
  def backend(); end

  def backend=(name); end

  def depth(); end

  def depth=(depth); end

  def parse(*arg, **arg1, &arg2); end

  def rename_key(key, options=T.unsafe(nil)); end

  def to_tag(key, value, options); end

  def with_backend(name); end
  DEFAULT_ENCODINGS = ::T.let(nil, ::T.untyped)
  FORMATTING = ::T.let(nil, ::T.untyped)
  PARSING = ::T.let(nil, ::T.untyped)
  TYPE_NAMES = ::T.let(nil, ::T.untyped)
end

module ActiveSupport::XmlMini::FileLike
  def content_type(); end

  def content_type=(content_type); end

  def original_filename(); end

  def original_filename=(original_filename); end
end

module ActiveSupport::XmlMini::FileLike
end

module ActiveSupport::XmlMini
  extend ::ActiveSupport::XmlMini
end

module ActiveSupport
  extend ::ActiveSupport::LazyLoadHooks
  extend ::ActiveSupport::Autoload
  def self.cache_format_version(); end

  def self.cache_format_version=(value); end

  def self.deprecator(); end

  def self.error_reporter(); end

  def self.error_reporter=(error_reporter); end

  def self.escape_html_entities_in_json(*arg, **arg1, &arg2); end

  def self.escape_html_entities_in_json=(arg); end

  def self.gem_version(); end

  def self.json_encoder(*arg, **arg1, &arg2); end

  def self.json_encoder=(arg); end

  def self.parse_json_times(); end

  def self.parse_json_times=(val); end

  def self.test_order(); end

  def self.test_order=(val); end

  def self.test_parallelization_threshold(); end

  def self.test_parallelization_threshold=(val); end

  def self.time_precision(*arg, **arg1, &arg2); end

  def self.time_precision=(arg); end

  def self.to_time_preserves_timezone(); end

  def self.to_time_preserves_timezone=(value); end

  def self.use_standard_json_time_format(*arg, **arg1, &arg2); end

  def self.use_standard_json_time_format=(arg); end

  def self.utc_to_local_returns_utc_offset_times(); end

  def self.utc_to_local_returns_utc_offset_times=(value); end

  def self.version(); end
end


class Date
  include ::DateAndTime::Zones
  include ::DateAndTime::Calculations
  def advance(options); end

  def ago(seconds); end

  def at_beginning_of_day(); end

  def at_end_of_day(); end

  def at_midday(); end

  def at_middle_of_day(); end

  def at_midnight(); end

  def at_noon(); end

  def beginning_of_day(); end

  def change(options); end

  def compare_with_coercion(other); end

  def compare_without_coercion(arg); end

  def deconstruct_keys(arg); end

  def default_inspect(); end

  def end_of_day(); end

  def in(seconds); end

  def infinite?(); end

  def midday(); end

  def middle_of_day(); end

  def midnight(); end

  def minus_with_duration(other); end

  def minus_without_duration(arg); end

  def noon(); end

  def plus_with_duration(other); end

  def plus_without_duration(arg); end

  def readable_inspect(); end

  def since(seconds); end

  def to_formatted_s(format=T.unsafe(nil)); end

  def to_fs(format=T.unsafe(nil)); end
  DATE_FORMATS = ::T.let(nil, ::T.untyped)
  VERSION = ::T.let(nil, ::T.untyped)
end

class Date::Infinity
  def initialize(d=T.unsafe(nil)); end
end

class Date
  def self.beginning_of_week(); end

  def self.beginning_of_week=(week_start); end

  def self.beginning_of_week_default(); end

  def self.beginning_of_week_default=(beginning_of_week_default); end

  def self.current(); end

  def self.find_beginning_of_week!(week_start); end

  def self.tomorrow(); end

  def self.yesterday(); end
end

module DateAndTime
end

module DateAndTime::Calculations
  def after?(date_or_time); end

  def all_day(); end

  def all_month(); end

  def all_quarter(); end

  def all_week(start_day=T.unsafe(nil)); end

  def all_year(); end

  def at_beginning_of_month(); end

  def at_beginning_of_quarter(); end

  def at_beginning_of_week(start_day=T.unsafe(nil)); end

  def at_beginning_of_year(); end

  def at_end_of_month(); end

  def at_end_of_quarter(); end

  def at_end_of_week(start_day=T.unsafe(nil)); end

  def at_end_of_year(); end

  def before?(date_or_time); end

  def beginning_of_month(); end

  def beginning_of_quarter(); end

  def beginning_of_week(start_day=T.unsafe(nil)); end

  def beginning_of_year(); end

  def days_ago(days); end

  def days_since(days); end

  def days_to_week_start(start_day=T.unsafe(nil)); end

  def end_of_month(); end

  def end_of_quarter(); end

  def end_of_week(start_day=T.unsafe(nil)); end

  def end_of_year(); end

  def future?(); end

  def last_month(); end

  def last_quarter(); end

  def last_week(start_day=T.unsafe(nil), same_time: T.unsafe(nil)); end

  def last_weekday(); end

  def last_year(); end

  def monday(); end

  def months_ago(months); end

  def months_since(months); end

  def next_day?(); end

  def next_occurring(day_of_week); end

  def next_quarter(); end

  def next_week(given_day_in_next_week=T.unsafe(nil), same_time: T.unsafe(nil)); end

  def next_weekday(); end

  def on_weekday?(); end

  def on_weekend?(); end

  def past?(); end

  def prev_day?(); end

  def prev_occurring(day_of_week); end

  def prev_quarter(); end

  def prev_week(start_day=T.unsafe(nil), same_time: T.unsafe(nil)); end

  def prev_weekday(); end

  def quarter(); end

  def sunday(); end

  def today?(); end

  def tomorrow(); end

  def tomorrow?(); end

  def weeks_ago(weeks); end

  def weeks_since(weeks); end

  def years_ago(years); end

  def years_since(years); end

  def yesterday(); end

  def yesterday?(); end
  DAYS_INTO_WEEK = ::T.let(nil, ::T.untyped)
  WEEKEND_DAYS = ::T.let(nil, ::T.untyped)
end

module DateAndTime::Calculations
end

module DateAndTime::Compatibility
  def preserve_timezone(); end

  def utc_to_local_returns_utc_offset_times(); end
end

module DateAndTime::Compatibility
  def self.preserve_timezone(); end

  def self.preserve_timezone=(val); end

  def self.utc_to_local_returns_utc_offset_times(); end

  def self.utc_to_local_returns_utc_offset_times=(val); end
end

module DateAndTime::Zones
  def in_time_zone(zone=T.unsafe(nil)); end
end

module DateAndTime::Zones
end

module DateAndTime
end

class DateTime
  def at_beginning_of_hour(); end

  def at_beginning_of_minute(); end

  def at_end_of_hour(); end

  def at_end_of_minute(); end

  def beginning_of_hour(); end

  def beginning_of_minute(); end

  def end_of_hour(); end

  def end_of_minute(); end

  def formatted_offset(colon=T.unsafe(nil), alternate_utc_string=T.unsafe(nil)); end

  def getgm(); end

  def getlocal(utc_offset=T.unsafe(nil)); end

  def getutc(); end

  def gmtime(); end

  def localtime(utc_offset=T.unsafe(nil)); end

  def nsec(); end

  def seconds_since_midnight(); end

  def seconds_until_end_of_day(); end

  def subsec(); end

  def to_f(); end

  def to_i(); end

  def usec(); end

  def utc(); end

  def utc?(); end

  def utc_offset(); end
end

class DateTime
  def self.civil_from_format(utc_or_local, year, month=T.unsafe(nil), day=T.unsafe(nil), hour=T.unsafe(nil), min=T.unsafe(nil), sec=T.unsafe(nil)); end

  def self.new(*arg); end
end
