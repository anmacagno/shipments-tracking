class SynchronizeShipments
  include Interactor::Organizer

  organize([
    Steps::FindShipments,
    Steps::TrackShipments,
    Steps::UpdateShipments,
    Steps::PublishNotifications
  ])
end
