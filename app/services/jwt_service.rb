
class JwtService
    
    def self.encode(payload)
      return JWT.encode(payload, Rails.application.secret_key_base)  # Use Rails secret key
    end
  
  
    def self.decode(token)
      begin
        
        decoded = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')
        decoded[0]  # Return the payload (contains user_id, exp, etc.)
      rescue JWT::DecodeError => e
        Rails.logger.error "JWT decode error: #{e.message}"
        raise JWT::DecodeError, "Invalid token"
      end
    end
  end
  