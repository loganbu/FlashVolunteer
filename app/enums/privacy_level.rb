class PrivacyLevel < ClassyEnum::Base
  enum_classes :self, :friends, :everyone
end

class PrivacyLevelSelf < PrivacyLevel
end

class PrivacyLevelFriends < PrivacyLevel
end

class PrivacyLevelEveryone < PrivacyLevel
end

