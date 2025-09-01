import 'package:chatcore/chat-core.dart';

/// Chat core manager responsible for initializing and managing chat functionality components
///
/// Uses singleton pattern to ensure only one global instance
class ChatCoreManager {
  /// Private constructor to prevent external instantiation
  ChatCoreManager._internal();

  /// Factory constructor that returns singleton instance
  factory ChatCoreManager() => _instance;

  /// Singleton instance
  static final ChatCoreManager _instance = ChatCoreManager._internal();

  /// Whether in lite mode
  bool _isLite = false;

  /// Get current lite mode status
  bool get isLite => _isLite;

  /// circle relay
  String? _circleRelay;

  /// Get current circle relay
  String? get circleRelay => _circleRelay;

  /// Initialize chat core functionality with configuration
  ///
  /// [config] - Unified configuration containing all initialization parameters
  ///
  /// Throws exception if initialization fails
  Future<void> initChatCoreWithConfig(ChatCoreInitConfig config) async {
    try {
      _isLite = config.isLite;

      _circleRelay = config.circleRelay;

      // Load all event cache from database
      await EventCache.sharedInstance.loadAllEventsFromDB();

      // Initialize relay service
      await Relays.sharedInstance.init(circleRelay: config.circleRelay);

      // Initialize core components with configuration
      await _initCoreComponentsWithConfig(config);

      // Initialize extended features if not in lite mode
      if (!_isLite) {
        await _initExtendedFeaturesWithConfig(config);
      }
    } catch (e, stack) {
      // Log error and rethrow
      print('ChatCoreManager initialization failed: $e, $stack');
      rethrow;
    }
  }

  /// Initialize chat core functionality (legacy method)
  ///
  /// [isLite] - Whether to enable lite mode, channels and moments are not loaded in lite mode
  /// [contactUpdatedCallBack] - Contact update callback
  /// [channelsUpdatedCallBack] - Channels update callback
  /// [groupsUpdatedCallBack] - Groups update callback
  /// [relayGroupsUpdatedCallBack] - Relay groups update callback
  ///
  /// Throws exception if initialization fails
  @Deprecated('Use initChatCoreWithConfig instead')
  Future<void> initChatCore({
    bool isLite = false,
    String? circleRelay,
    ContactUpdatedCallBack? contactUpdatedCallBack,
    ChannelsUpdatedCallBack? channelsUpdatedCallBack,
    GroupsUpdatedCallBack? groupsUpdatedCallBack,
    GroupsUpdatedCallBack? relayGroupsUpdatedCallBack,
  }) async {
    try {
      _isLite = isLite;

      // Load all event cache from database
      await EventCache.sharedInstance.loadAllEventsFromDB();

      // Initialize relay service
      await Relays.sharedInstance.init(circleRelay: circleRelay);

      // Initialize core components
      await _initCoreComponents(
        contactUpdatedCallBack: contactUpdatedCallBack,
        groupsUpdatedCallBack: groupsUpdatedCallBack,
      );

      // Initialize extended features if not in lite mode
      if (!_isLite) {
        await _initExtendedFeatures(
          channelsUpdatedCallBack: channelsUpdatedCallBack,
          relayGroupsUpdatedCallBack: relayGroupsUpdatedCallBack,
        );
      }
    } catch (e) {
      // Log error and rethrow
      print('ChatCoreManager initialization failed: $e');
      rethrow;
    }
  }

  /// Initialize core components with configuration
  Future<void> _initCoreComponentsWithConfig(ChatCoreInitConfig config) async {
    // Initialize core components in parallel for better performance
    await Future.wait([
      Future(() => Messages.sharedInstance.init()),
      Future(() => Contacts.sharedInstance.init(callBack: config.contactUpdatedCallBack)),
      Future(() => Groups.sharedInstance.initWithConfig(config)),
      Future(() => RelayGroup.sharedInstance.init(callBack: config.relayGroupsUpdatedCallBack)),
      Future(() => NotificationHelper.sharedInstance.setServerRelay(config.pushServerRelay)),
    ]);
  }

  /// Initialize extended features with configuration
  Future<void> _initExtendedFeaturesWithConfig(ChatCoreInitConfig config) async {
    // Initialize extended features in parallel
    await Future.wait([
      Future(() => Channels.sharedInstance.init(callBack: config.channelsUpdatedCallBack)),
      Future(() => Moment.sharedInstance.init()),
      Future(() => BadgesHelper.sharedInstance.init()),
      Future(() => Zaps.sharedInstance.init()),
    ]);
  }

  /// Initialize core components (legacy method)
  Future<void> _initCoreComponents({
    ContactUpdatedCallBack? contactUpdatedCallBack,
    GroupsUpdatedCallBack? groupsUpdatedCallBack,
  }) async {
    // Initialize core components in parallel for better performance
    await Future.wait([
      Future(() => Messages.sharedInstance.init()),
      Future(() => Contacts.sharedInstance.init(callBack: contactUpdatedCallBack)),
      Future(() => Groups.sharedInstance.init(callBack: groupsUpdatedCallBack)),
    ]);
  }

  /// Initialize extended features
  Future<void> _initExtendedFeatures({
    ChannelsUpdatedCallBack? channelsUpdatedCallBack,
    GroupsUpdatedCallBack? relayGroupsUpdatedCallBack,
  }) async {
    // Initialize extended features in parallel
    await Future.wait([
      Future(() => Channels.sharedInstance.init(callBack: channelsUpdatedCallBack)),
      Future(() => Moment.sharedInstance.init()),
      Future(() => BadgesHelper.sharedInstance.init()),
      Future(() => Zaps.sharedInstance.init()),
      Future(() => RelayGroup.sharedInstance.init(callBack: relayGroupsUpdatedCallBack)),
    ]);
  }

  List<int> myProfileKinds() {
    return _isLite ? [0, 3] : [0, 3, 10000, 10002, 10005, 10009, 10050, 30000, 30001, 30003, 30008];
  }

  List<int> userProfileKinds() {
    return _isLite ? [0] : [0, 10002, 10050, 30008];
  }

  bool isAcceptedEventKind(int kind) {
    final accepted = _isLite ? [0, 443, 444, 445, 1059, 10051, 7, 9] : [];
    return accepted.isEmpty || accepted.contains(kind);
  }
}
