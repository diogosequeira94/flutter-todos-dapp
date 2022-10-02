# Todos dApp with BLoC

Simple Todos app that let's add and delete notes sending transactions to a local blockchain

- Fetch Notes
- Get note by ID
- Add note
- Delete note

## Requirements 
- Android Studio / VScode
- Node.js
- Truffle (npm install -g truffle)
- Ganache (local blockchain)

## Folder structure
```
|-- flutter_todos_dapp
        ...
        -- contracts
        |   |-- Migrations.sol
        |   |-- NotesContract.sol
        |-- lib
        |   |-- bloc
        |   |   |-- notes_service_bloc.dart
        |   |   |-- notes_service_event.dart
        |   |   |-- notes_service_state.dart
        |   |-- models
        |   |   |-- note.dart
        |   |-- repository
        |   |   |-- endpoints.dart
        |   |   |-- notes_deployed_contract.dart
        |   |   |-- notes_repository.dart
        |   |   |-- notes_web3_api_client.dart
        |   |-- view
        |   |   |-- add_note_form.dart
        |   |   |-- home_page.dart
        |   |-- main.dart
        -- migrations
        |   |-- 1_initial_migration.js
        |   |-- 2_notescontract_migration.js
        ...
    
```

## Tech Used

**Server**: Ganash, Truffle
**Smart Contracts**: Solidity
**Client**: Flutter
**State Management**: BLoC
