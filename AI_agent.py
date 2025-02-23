import json
import numpy as np
import pandas as pd
from web3 import Web3
from sklearn.ensemble import RandomForestRegressor

class AICapitalAllocator:
    def __init__(self, blockchain_url, contract_address, contract_abi):
        self.model = RandomForestRegressor(n_estimators=100, random_state=42)
        self.web3 = Web3(Web3.HTTPProvider(blockchain_url))
        self.contract = self.web3.eth.contract(address=contract_address, abi=contract_abi)
    
    def fetch_funding_data(self):
        # Simulated dataset for funding decisions
        data = [
            {"project": "0xProject1", "impact_score": 85, "votes": 120, "amount": 5000},
            {"project": "0xProject2", "impact_score": 75, "votes": 95, "amount": 3000},
            {"project": "0xProject3", "impact_score": 90, "votes": 140, "amount": 7000},
        ]
        return pd.DataFrame(data)

    def train_model(self):
        data = self.fetch_funding_data()
        X = data[["impact_score", "votes"]].values
        y = data["amount"].values
        self.model.fit(X, y)
    
    def ai_funding_decision(self, impact_score, votes):
        return self.model.predict([[impact_score, votes]])[0]
    
    def allocate_funds(self, recipient, amount, sender_account, private_key):
        nonce = self.web3.eth.get_transaction_count(sender_account)
        txn = self.contract.functions.allocateFunds(recipient, int(amount)).build_transaction({
            'chainId': self.web3.eth.chain_id,
            'gas': 2000000,
            'gasPrice': self.web3.to_wei('20', 'gwei'),
            'nonce': nonce
        })
        signed_txn = self.web3.eth.account.sign_transaction(txn, private_key=private_key)
        tx_hash = self.web3.eth.send_raw_transaction(signed_txn.rawTransaction)
        return tx_hash.hex()

if __name__ == "__main__":
    blockchain_url = "https://your-blockchain-node"
    contract_address = "0xYourContractAddress"
    contract_abi = json.loads('your_contract_abi_here')

    allocator = AICapitalAllocator(blockchain_url, contract_address, contract_abi)
    allocator.train_model()

    impact_score, votes = 85, 120
    recommended_amount = allocator.ai_funding_decision(impact_score, votes)
    print(f"AI Recommended Funding: {recommended_amount}")