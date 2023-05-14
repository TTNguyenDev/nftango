module overmind::nftango {
    use std::option::Option;
    use std::string::String;
    use aptos_framework::account;
    use std::vector;
    use aptos_token::token::TokenId;

    //
    // Errors
    //
    const ERROR_NFTANGO_STORE_EXISTS: u64 = 0;
    const ERROR_NFTANGO_STORE_DOES_NOT_EXIST: u64 = 1;
    const ERROR_NFTANGO_STORE_IS_ACTIVE: u64 = 2;
    const ERROR_NFTANGO_STORE_IS_NOT_ACTIVE: u64 = 3;
    const ERROR_NFTANGO_STORE_HAS_AN_OPPONENT: u64 = 4;
    const ERROR_NFTANGO_STORE_DOES_NOT_HAVE_AN_OPPONENT: u64 = 5;
    const ERROR_NFTANGO_STORE_JOIN_AMOUNT_REQUIREMENT_NOT_MET: u64 = 6;
    const ERROR_NFTANGO_STORE_DOES_NOT_HAVE_DID_CREATOR_WIN: u64 = 7;
    const ERROR_NFTANGO_STORE_HAS_CLAIMED: u64 = 8;
    const ERROR_NFTANGO_STORE_IS_NOT_PLAYER: u64 = 9;
    const ERROR_VECTOR_LENGTHS_NOT_EQUAL: u64 = 10;

    //
    // Data structures
    //
    struct NFTangoStore has key {
        creator_token_id: TokenId,
        // The number of NFTs (one more more) from the same collection that the opponent needs to bet to enter the game
        join_amount_requirement: u64,
        opponent_address: Option<address>,
        opponent_token_ids: vector<TokenId>,
        active: bool,
        has_claimed: bool,
        did_creator_win: Option<bool>,
        signer_capability: account::SignerCapability
    }

    //
    // Assert functions
    //
    public fun assert_nftango_store_exists(
        account_address: address,
    ) {
        // TODO: assert that `NFTangoStore` exists
        assert!(exists<NFTangoStore>(account_address), ERROR_NFTANGO_STORE_DOES_NOT_EXIST);
    }

    public fun assert_nftango_store_does_not_exist(
        account_address: address,
    ) {
        // TODO: assert that `NFTangoStore` does not exist
        assert!(!exists<NFTangoStore>(account_address), ERROR_NFTANGO_STORE_EXISTS);
    }

    public fun assert_nftango_store_is_active(
        account_address: address,
    ) acquires NFTangoStore {
        assert_nftango_store_exists(account_address);
        // TODO: assert that `NFTangoStore.active` is active
        let nftango_store = borrow_global<NFTangoStore>(account_address);
        assert!(nftango_store.active, ERROR_NFTANGO_STORE_IS_NOT_ACTIVE);
    }

    public fun assert_nftango_store_is_not_active(
        account_address: address,
    ) acquires NFTangoStore {
        assert_nftango_store_exists(account_address);
        // TODO: assert that `NFTangoStore.active` is not active
        let nftango_store = borrow_global<NFTangoStore>(account_address);
        assert!(!nftango_store.active, ERROR_NFTANGO_STORE_IS_ACTIVE);
    }

    public fun assert_nftango_store_has_an_opponent(
        account_address: address,
    ) acquires NFTangoStore {
        assert_nftango_store_exists(account_address);
        // TODO: assert that `NFTangoStore.opponent_address` is set
        let nftango_store = borrow_global<NFTangoStore>(account_address);
        assert!(std::option::is_some(&nftango_store.opponent_address), ERROR_NFTANGO_STORE_DOES_NOT_HAVE_AN_OPPONENT);
    }

    public fun assert_nftango_store_does_not_have_an_opponent(
        account_address: address,
    ) acquires NFTangoStore {
        assert_nftango_store_exists(account_address);
         // TODO: assert that `NFTangoStore.opponent_address` is not set
        let nftango_store = borrow_global<NFTangoStore>(account_address);
        assert!(std::option::is_none(&nftango_store.opponent_address), ERROR_NFTANGO_STORE_HAS_AN_OPPONENT);
    }

    public fun assert_nftango_store_join_amount_requirement_is_met(
        game_address: address,
        token_ids: vector<TokenId>,
    ) acquires NFTangoStore {
        // TODO: assert that `NFTangoStore.join_amount_requirement` is met
          let nftango_store = borrow_global<NFTangoStore>(game_address);
          let nfts_len = vector::length(&token_ids);
          assert!(nftango_store.join_amount_requirement == nfts_len, ERROR_NFTANGO_STORE_JOIN_AMOUNT_REQUIREMENT_NOT_MET);
    }

    public fun assert_nftango_store_has_did_creator_win(
        game_address: address,
    ) acquires NFTangoStore {
        // TODO: assert that `NFTangoStore.did_creator_win` is set
        let nftango_store = borrow_global<NFTangoStore>(game_address);
        assert!(std::option::is_some(&nftango_store.did_creator_win), ERROR_NFTANGO_STORE_DOES_NOT_HAVE_DID_CREATOR_WIN);
    }

    public fun assert_nftango_store_has_not_claimed(
        game_address: address,
    ) acquires NFTangoStore {
        // TODO: assert that `NFTangoStore.has_claimed` is false
        let nftango_store = borrow_global<NFTangoStore>(game_address);
        assert!(nftango_store.has_claimed == false, ERROR_NFTANGO_STORE_HAS_CLAIMED);
    }

    public fun assert_nftango_store_is_player(account_address: address, game_address: address) acquires NFTangoStore {
        // TODO: assert that `account_address` is either the equal to `game_address` or `NFTangoStore.opponent_address`
        let nftango_store = borrow_global<NFTangoStore>(game_address);
        let opponent_address_option = nftango_store.opponent_address;
        if (std::option::is_some(&opponent_address_option)) {
            let opponent_address = std::option::extract(&mut opponent_address_option);
            assert!((account_address == game_address) || account_address == opponent_address, ERROR_NFTANGO_STORE_IS_NOT_PLAYER)
        } else {
            assert!((account_address == game_address), ERROR_NFTANGO_STORE_IS_NOT_PLAYER);
        }
    }

    public fun assert_vector_lengths_are_equal(creator: vector<address>,
                                               collection_name: vector<String>,
                                               token_name: vector<String>,
                                               property_version: vector<u64>) {
        // TODO: assert all vector lengths are equal
        let creator_len = vector::length(&creator);
        let collection_name_len = vector::length(&collection_name);
        let token_name_len = vector::length(&token_name);
        let property_version_len = vector::length(&property_version);
        assert!(creator_len == collection_name_len && collection_name_len == token_name_len && token_name_len == property_version_len, error::not_found(ERROR_VECTOR_LENGTHS_NOT_EQUAL));
    }

    //
    // Entry functions
    //
    public entry fun initialize_game(
        account: &signer,
        creator: address,
        collection_name: String,
        token_name: String,
        property_version: u64,
        join_amount_requirement: u64
    ) {
        // TODO: run assert_nftango_store_does_not_exist

        // TODO: create resource account

        // TODO: token::create_token_id_raw

        // TODO: opt in to direct transfer for resource account

        // TODO: transfer NFT to resource account

        // TODO: move_to resource `NFTangoStore` to account signer
    }

    public entry fun cancel_game(
        account: &signer,
    ) acquires NFTangoStore {
        // TODO: run assert_nftango_store_exists
        // TODO: run assert_nftango_store_is_active
        // TODO: run assert_nftango_store_does_not_have_an_opponent

        // TODO: opt in to direct transfer for account

        // TODO: transfer NFT to account address

        // TODO: set `NFTangoStore.active` to false
    }

    public fun join_game(
        account: &signer,
        game_address: address,
        creators: vector<address>,
        collection_names: vector<String>,
        token_names: vector<String>,
        property_versions: vector<u64>,
    ) acquires NFTangoStore {
        // TODO: run assert_vector_lengths_are_equal

        // TODO: loop through and create token_ids vector<TokenId>

        // TODO: run assert_nftango_store_exists
        // TODO: run assert_nftango_store_is_active
        // TODO: run assert_nftango_store_does_not_have_an_opponent
        // TODO: run assert_nftango_store_join_amount_requirement_is_met

        // TODO: loop through token_ids and transfer each NFT to the resource account

        // TODO: set `NFTangoStore.opponent_address` to account_address
        // TODO: set `NFTangoStore.opponent_token_ids` to token_ids
    }

    public entry fun play_game(account: &signer, did_creator_win: bool) acquires NFTangoStore {
        // TODO: run assert_nftango_store_exists
        // TODO: run assert_nftango_store_is_active
        // TODO: run assert_nftango_store_has_an_opponent

        // TODO: set `NFTangoStore.did_creator_win` to did_creator_win
        // TODO: set `NFTangoStore.active` to false
    }

    public entry fun claim(account: &signer, game_address: address) acquires NFTangoStore {
        // TODO: run assert_nftango_store_exists
        // TODO: run assert_nftango_store_is_not_active
        // TODO: run assert_nftango_store_has_not_claimed
        // TODO: run assert_nftango_store_is_player

        // TODO: if the player won, send them all the NFTs

        // TODO: set `NFTangoStore.has_claimed` to true
    }
}
