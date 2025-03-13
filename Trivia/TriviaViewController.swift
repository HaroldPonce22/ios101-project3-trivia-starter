import UIKit

// Define the Question struct at the top level (outside the class)
struct Question {
    let topic: String
    let text: String
    let answers: [String]
    let correctAnswer: String
}

class TriviaViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var questionNum: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var questionTextView:UITextView!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    // MARK: - Properties
        var currentQuestionIndex = 0
        var score = 0
        
        // Trivia Questions Data
        let triviaQuestions = [
            Question(topic: "Geography", text: "What is the capital of France?", answers: ["Paris", "London", "Berlin", "Madrid"], correctAnswer: "Paris"),
            Question(topic: "Astronomy", text: "Which planet is known as the Red Planet?", answers: ["Earth", "Mars", "Jupiter", "Saturn"], correctAnswer: "Mars"),
            Question(topic: "Literature", text: "Who wrote 'Romeo and Juliet'?", answers: ["Charles Dickens", "William Shakespeare", "Mark Twain", "Jane Austen"], correctAnswer: "William Shakespeare")
        ]
        
        // MARK: - Lifecycle Methods
        override func viewDidLoad() {
            super.viewDidLoad()
            updateUI()
        }
        
        // MARK: - Actions
        @IBAction func answerButtonTapped(_ sender: UIButton) {
            let selectedAnswer = sender.titleLabel?.text ?? ""
            checkAnswer(selectedAnswer)
        }
        
        // MARK: - Helper Methods
        func updateUI() {
            let currentQuestion = triviaQuestions[currentQuestionIndex]
            
            // Update question number label
            questionNum.text = "Question \(currentQuestionIndex + 1)"
            
            // Update topic label
            topicLabel.text = currentQuestion.topic
            
            // Update question text view
            questionTextView.text = currentQuestion.text
            
            // Update answer buttons
            answer1.setTitle(currentQuestion.answers[0], for: .normal)
            answer2.setTitle(currentQuestion.answers[1], for: .normal)
            answer3.setTitle(currentQuestion.answers[2], for: .normal)
            answer4.setTitle(currentQuestion.answers[3], for: .normal)
        }
        
        func checkAnswer(_ selectedAnswer: String) {
            let currentQuestion = triviaQuestions[currentQuestionIndex]
            if selectedAnswer == currentQuestion.correctAnswer {
                score += 1
                showAlert(title: "Correct!", message: "You got it right! 🎉")
            } else {
                showAlert(title: "Wrong!", message: "The correct answer is \(currentQuestion.correctAnswer).")
            }
        }
        
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Next Question", style: .default) { _ in
                self.goToNextQuestion()
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        func goToNextQuestion() {
            if currentQuestionIndex < triviaQuestions.count - 1 {
                currentQuestionIndex += 1
                updateUI()
            } else {
                // Show final score
                showFinalScore()
            }
        }
        
        func showFinalScore() {
            let finalScoreMessage = "Your final score is \(score)/\(triviaQuestions.count)."
            let alert = UIAlertController(title: "Game Over", message: finalScoreMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: "Play Again", style: .default) { _ in
                self.resetGame()
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        func resetGame() {
            currentQuestionIndex = 0
            score = 0
            updateUI()
        }
    }
