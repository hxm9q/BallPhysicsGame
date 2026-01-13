import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    weak var viewModel: GameViewModel?
    
    private var ball: SKSpriteNode!
    private var paddle: SKSpriteNode!
    private var walls: [SKNode] = []
    
    private let ballCategory: UInt32 = 0x1 << 0
    private let paddleCategory: UInt32 = 0x1 << 1
    private let wallCategory: UInt32 = 0x1 << 2
    private let bottomCategory: UInt32 = 0x1 << 3
    
    private var ballSpeed: CGFloat = 400.0
    
    override init(size: CGSize) {
        super.init(size: size)
        physicsWorld.gravity = .zero
        physicsWorld.contactDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset() {
        removeAllChildren()
        setupWalls()
        setupPaddle()
        setupBall()
        launchBall()
    }
    
    private func setupWalls() {
        let border = SKPhysicsBody(edgeLoopFrom: frame)
        border.friction = 0
        border.restitution = 1
        let borderNode = SKNode()
        borderNode.physicsBody = border
        borderNode.physicsBody?.categoryBitMask = wallCategory
        addChild(borderNode)
        
        let bottom = SKNode()
        let bottomRect = CGRect(x: 0, y: -10, width: size.width, height: 10)
        bottom.physicsBody = SKPhysicsBody(edgeLoopFrom: bottomRect)
        bottom.physicsBody?.categoryBitMask = bottomCategory
        bottom.physicsBody?.contactTestBitMask = ballCategory
        addChild(bottom)
    }
    
    private func setupPaddle() {
        paddle = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: 20))
        paddle.position = CGPoint(x: size.width / 2, y: 50)
        paddle.physicsBody = SKPhysicsBody(rectangleOf: paddle.size)
        paddle.physicsBody?.isDynamic = false
        paddle.physicsBody?.friction = 0
        paddle.physicsBody?.restitution = 1
        paddle.physicsBody?.categoryBitMask = paddleCategory
        paddle.physicsBody?.contactTestBitMask = ballCategory
        addChild(paddle)
    }
    
    private func setupBall() {
        ball = SKSpriteNode(color: .red, size: CGSize(width: 20, height: 20))
        ball.position = CGPoint(x: size.width / 2, y: size.height / 2)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        ball.physicsBody?.friction = 0
        ball.physicsBody?.restitution = 1
        ball.physicsBody?.linearDamping = 0
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.collisionBitMask = wallCategory | paddleCategory
        ball.physicsBody?.contactTestBitMask = paddleCategory | bottomCategory
        addChild(ball)
    }
    
    private func launchBall() {
        let angle = CGFloat.random(in: -CGFloat.pi/4 ... CGFloat.pi/4)
        let dx = ballSpeed * sin(angle)
        let dy = ballSpeed * cos(angle)
        ball.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
    }
    
    func movePaddle(to x: CGFloat, in width: CGFloat) {
        let halfPaddle = paddle.size.width / 2
        let newX = max(halfPaddle, min(x, width - halfPaddle))
        paddle.position.x = newX
    }
    
    func increaseBallSpeed() {
        ballSpeed += 20
        if let velocity = ball.physicsBody?.velocity {
            let currentSpeed = sqrt(velocity.dx * velocity.dx + velocity.dy * velocity.dy)
            let scale = ballSpeed / currentSpeed
            ball.physicsBody?.velocity = CGVector(dx: velocity.dx * scale, dy: velocity.dy * scale)
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == ballCategory | paddleCategory {
            viewModel?.incrementScore()
        } else if contactMask == ballCategory | bottomCategory {
            viewModel?.endGame()
            ball.removeFromParent()
        }
    }
    
}
