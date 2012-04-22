class PrivacyLevel < ClassyEnum::Base
  enum_classes :self, :everyone
end

class PrivacyLevelSelf < PrivacyLevel
end

class PrivacyLevelEveryone < PrivacyLevel
end

