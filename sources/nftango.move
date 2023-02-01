module overmind::nftango {
    use aptos_framework::account;
    use aptos_token::token;
    use std::option::Option;
    use std::error;
    use std::signer;
    use std::vector;
    use std::option;

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
    const ERROR_NFTS_ARE_NOT_IN_THE_SAME_COLLECTION: u64 = 7;
    const ERROR_NFTANGO_STORE_DOES_NOT_HAVE_DID_CREATOR_WIN: u64 = 8;
    const ERROR_NFTANGO_STORE_HAS_CLAIMED: u64 = 9;
    const ERROR_NFTANGO_STORE_IS_NOT_PLAYER: u64 = 10;

    //
    // Data structures
    //
    struct NFTangoStore has key {
        creator_token_id: token::TokenId,
        // The number of NFTs (one more more) from the same collection that the opponent needs to bet to enter the game
        join_amount_requirement: u64,
        opponent_address: Option<address>,
        opponent_token_ids: vector<token::TokenId>,
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
    }

    public fun assert_nftango_store_does_not_exist(
        account_address: address,
    ) {
        // TODO: assert that `NFTangoStore` does not exist
    }

    public fun assert_nftango_store_is_active(
        account_address: address,
    ) acquires NFTangoStore {
        // TODO: assert that `NFTangoStore.active` is active
    }

    public fun assert_nftango_store_is_not_active(
        account_address: address,
    ) acquires NFTangoStore {
        // TODO: assert that `NFTangoStore.active` is not active
    }

    public fun assert_nftango_store_has_an_opponent(
        account_address: address,
    ) acquires NFTangoStore {
        // TODO: assert that `NFTangoStore.opponent_address` is set
    }

    public fun assert_nftango_store_does_not_have_an_opponent(
        account_address: address,
    ) acquires NFTangoStore {
        // TODO: assert that `NFTangoStore.opponent_address` is not set
    }

    public fun assert_nftango_store_join_amount_requirement_is_met(
        game_address: address,
        token_ids: vector<token::TokenId>,
    ) acquires NFTangoStore {
        // TODO: assert that `NFTangoStore.join_amount_requirement` is met
    }

    public fun assert_nfts_are_in_the_same_collection(
        game_address: address,
        token_ids: vector<token::TokenId>,
    ) acquires NFTangoStore {
        // TODO: assert that `NFTangoStore.creator_token_id` and `token_ids` are all have the same `creator`, `collection`, and `name`
    }

    public fun assert_nftango_store_has_did_creator_win(
        game_address: address,
    ) acquires NFTangoStore {
        // TODO: assert that `NFTangoStore.did_creator_win` is set
    }

    public fun assert_nftango_store_has_not_claimed(
        game_address: address,
    ) acquires NFTangoStore {
        // TODO: assert that `NFTangoStore.has_claimed` is false
    }

    public fun assert_nftango_store_is_player(account_address: address, game_address: address) acquires NFTangoStore {
        // TODO: assert that `account_address` is either the equal to `game_address` or `NFTangoStore.opponent_address`
    }

    //
    // Entry functions
    //
    public entry fun initialize_game(
        account: &signer,
        token_id: token::TokenId,
        join_amount_requirement: u64
    ) {
        // TODO: run assert_nftango_store_exists

        // TODO: create resource account

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

    public entry fun join_game(
        account: &signer,
        game_address: address,
        token_ids: vector<token::TokenId>,
    ) acquires NFTangoStore {
        // TODO: run assert_nftango_store_exists
        // TODO: run assert_nftango_store_is_active
        // TODO: run assert_nftango_store_does_not_have_an_opponent
        // TODO: run assert_nftango_store_join_amount_requirement_is_met
        // TODO: run assert_nfts_are_in_the_same_collection

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