from fastapi import FastAPI

app = FastAPI(
    title="Usman E-commerce API",
    description="Backend API for the AWS E-commerce project",
    version="1.0.0"
)

products = [
    {"id": 1, "name": "Laptop", "price": 550, "currency": "GBP"},
    {"id": 2, "name": "Mobile", "price": 250, "currency": "GBP"},
    {"id": 3, "name": "Keyboard", "price": 15, "currency": "GBP"},
    {"id": 4, "name": "Monitor", "price": 120, "currency": "GBP"}
]

@app.get("/")
def home():
    return {"message": "Welcome to the E-commerce API"}

@app.get("/health")
def health():
    return {"status": "healthy"}

@app.get("/products")
def get_products():
    return products
