
import { useEffect, useState } from 'react'
import {
  Search, ShoppingCart, User, Laptop, Smartphone,
  Sofa, Shirt, Heart, Car, Headphones, ShieldCheck,
  Truck, RotateCcw, Trophy, ChevronRight, Tag
} from 'lucide-react'
import './App.css'

const categories = [
  { name: 'Electronics', icon: Laptop },
  { name: 'Mobile Phones', icon: Smartphone },
  { name: 'Home & Furniture', icon: Sofa },
  { name: 'Fashion', icon: Shirt },
  { name: 'Health & Beauty', icon: Heart },
  { name: 'Sports & Outdoors', icon: Trophy },
  { name: 'Vehicles', icon: Car },
  { name: 'Audio & Accessories', icon: Headphones },
]

type ApiProduct = {
  id: number
  name: string
  price: number
  currency: string
}

type Product = ApiProduct & {
  category: string
  image: string
  tag: string
}

function App() {
  const [search, setSearch] = useState('')
  const [cartCount, setCartCount] = useState(0)
  const [selectedCategory, setSelectedCategory] = useState('All')
  const [products, setProducts] = useState<Product[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')

  useEffect(() => {
    const loadProducts = async () => {
      try {
        setLoading(true)
        setError('')

        const response = await fetch('/api/products')

        if (!response.ok) {
          throw new Error(`API request failed: ${response.status}`)
        }

        const apiProducts: ApiProduct[] = await response.json()

        const productDetails: Record<number, Omit<Product, keyof ApiProduct>> = {
          1: {
            category: 'Electronics',
            image: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=700&auto=format&fit=crop',
            tag: 'Available',
          },
          2: {
            category: 'Mobile Phones',
            image: 'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=700&auto=format&fit=crop',
            tag: 'Available',
          },
          3: {
            category: 'Electronics',
            image: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=700&auto=format&fit=crop',
            tag: 'Available',
          },
          4: {
            category: 'Electronics',
            image: 'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=700&auto=format&fit=crop',
            tag: 'Available',
          },
        }

        setProducts(
          apiProducts.map((product) => ({
            ...product,
            ...(productDetails[product.id] || {
              category: 'Electronics',
              image: '',
              tag: 'Available',
            }),
          }))
        )
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Unable to load products')
      } finally {
        setLoading(false)
      }
    }

    loadProducts()
  }, [])

  const filteredProducts = products.filter((product) => {
    const matchesSearch =
      product.name.toLowerCase().includes(search.toLowerCase())
    const matchesCategory =
      selectedCategory === 'All' || product.category === selectedCategory
    return matchesSearch && matchesCategory
  })

  return (
    <div className="marketplace">
      <div className="top-bar">
        <span><Truck size={17} /> Free UK Delivery on orders over £50</span>
        <span><ShieldCheck size={17} /> Secure Payments</span>
        <span><Headphones size={17} /> Customer Support</span>
        <span><User size={17} /> Login / Register</span>
        <span><ShoppingCart size={18} /> Cart ({cartCount})</span>
      </div>

      <header className="main-header">
        <a className="brand" href="/">
          <span className="brand-icon"><ShoppingCart size={34} /></span>
          <span>
            <strong>Usman Abubakar</strong>
            <b>E-Commerce Project</b>
          </span>
        </a>

        <div className="search-box">
          <input
            value={search}
            onChange={(event) => setSearch(event.target.value)}
            placeholder="Search for products..."
          />
          <button aria-label="Search"><Search size={21} /></button>
        </div>

        <nav className="main-nav">
          <a href="#home">Home</a>
          <a href="#categories">Categories</a>
          <a href="#products">Deals</a>
          <a href="#footer">Contact</a>
        </nav>
      </header>

      <main>
        <section className="hero" id="home">
          <div className="hero-content">
            <span className="eyebrow">WELCOME TO OUR MARKETPLACE</span>
            <h1>Usman Abubakar<br /><span>E-Commerce Project</span></h1>
            <h2>Shop Smarter. Live Better.</h2>
            <p>Discover amazing products at great prices, with convenient shopping and reliable service.</p>
            <a className="primary-button" href="#products">Shop Now <ChevronRight size={19} /></a>
          </div>
          <div className="hero-image" role="img" aria-label="Modern online shopping" />
        </section>

        <section className="benefits">
          <div><ShieldCheck /><span><strong>Secure Payments</strong><small>Shop with confidence</small></span></div>
          <div><Truck /><span><strong>Reliable Delivery</strong><small>Across the UK</small></span></div>
          <div><RotateCcw /><span><strong>Easy Returns</strong><small>Simple returns process</small></span></div>
          <div><Trophy /><span><strong>Trusted Marketplace</strong><small>Quality and value</small></span></div>
        </section>

        <section className="section" id="categories">
          <div className="section-heading">
            <div><span className="eyebrow">EXPLORE OUR STORE</span><h2>Shop by Category</h2></div>
          </div>
          <div className="category-grid">
            {categories.map(({ name, icon: Icon }) => (
              <button
                className={`category-card ${selectedCategory === name ? 'selected' : ''}`}
                key={name}
                onClick={() => {
                  setSelectedCategory(name)
                  document.getElementById('products')?.scrollIntoView({ behavior: 'smooth' })
                }}
              >
                <Icon size={27} />
                <span>{name}</span>
                <ChevronRight size={17} />
              </button>
            ))}
          </div>
        </section>

        <section className="section" id="products">
          <div className="section-heading">
            <div><span className="eyebrow">HANDPICKED FOR YOU</span><h2>Featured Products</h2></div>
            <button className="view-all" onClick={() => setSelectedCategory('All')}>View All Products <ChevronRight size={17} /></button>
          </div>

          <div className="product-grid">
            {loading && <p className="empty-state">Loading products...</p>}

            {!loading && error && (
              <p className="empty-state">Unable to load products: {error}</p>
            )}

            {!loading && !error && filteredProducts.map((product) => (
              <article className="product-card" key={product.id}>
                <div className="product-image">
                  <img src={product.image} alt={product.name} loading="lazy" />
                  <span className="product-tag">{product.tag}</span>
                </div>
                <div className="product-info">
                  <small>{product.category}</small>
                  <h3>{product.name}</h3>
                  <div className="rating">New product <span>Available to order</span></div>
                  <div className="product-bottom">
                    <strong>£{product.price.toFixed(2)}</strong>
                    <button onClick={() => setCartCount((count) => count + 1)}>
                      <ShoppingCart size={16} /> Add to Cart
                    </button>
                  </div>
                </div>
              </article>
            ))}
            {!loading && !error && filteredProducts.length === 0 && (
              <p className="empty-state">No products found. Try another search or category.</p>
            )}
          </div>
        </section>

        <section className="seller-banner">
          <div><Tag size={32} /><span><strong>Are you a seller?</strong><small>Grow your business and reach more customers with our marketplace.</small></span></div>
          <button>Become a Seller <ChevronRight size={18} /></button>
        </section>
      </main>


      <footer id="footer">
        <div className="footer-brand">
          <ShoppingCart size={30} />
          <span><strong>Usman Abubakar</strong><b>E-Commerce Project</b></span>
        </div>
        <p>© {new Date().getFullYear()} Usman Abubakar E-Commerce Project. All rights reserved.</p>
      </footer>
    </div>
  )
}

export default App

